import boto3
import logging
import botocore.exceptions


LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)
logging.getLogger('boto3').setLevel(logging.CRITICAL)
logging.getLogger('botocore').setLevel(logging.CRITICAL)

SSM_PARAM_PREFIX = '/dbs/tagging/'
DBS_STANDARD_TAGS = dict([
    ("dbs-projectowners", (SSM_PARAM_PREFIX + "projectowners", "N/A")),
    ("dbs-project", (SSM_PARAM_PREFIX + "project", "N/A")),
    ("dbs-projecttype", (SSM_PARAM_PREFIX + "projecttype", "N/A")),
    ("dbs-codeowners", (SSM_PARAM_PREFIX + "codeowners", "N/A")),
    ("dbs-dataowners", (SSM_PARAM_PREFIX + "dataowners", "N/A")),
    ("dbs-environment", (SSM_PARAM_PREFIX + "environment", "production")),
    ("dbs-availability", (SSM_PARAM_PREFIX + "availability", "always_on")),
    ("dbs-deployer", ("", "ControlTower")),
    ("dbs-deletiondate", ("", "N/A")),
    ("dbs-confidentiality", ("", "confidential")),
    ("dbs-dataregulations", ("", "N/A")),
    ("dbs-securityreview", ("", "N/A")),
    ("dbs-privacyreview", ("", "N/A")),
    ("Name", ("", "TODO")),
])


class Tagger:
    ssm_client = boto3.client('ssm', 'us-east-2')
    org_client = boto3.client('organizations', 'us-east-2')
    service_catalog_client = boto3.client('servicecatalog', 'us-east-2')


def handler(event, context):
    if 'detail' in event:
        LOGGER.info("Received eventName=%s", event['detail']['eventName'])
    find_and_tag_untagged_resources()


def find_and_tag_untagged_resources():
    parameters = retrieve_default_accountwide_dbs_tag_values_from_ssm_parameters()
    root_id = tag_organization_root_if_needed(parameters)
    tag_orgnizational_units_where_needed(parameters, root_id)
    tag_organizational_accounts_where_needed(parameters)
    tag_service_control_policies_where_needed(parameters)
    tag_service_catalog_products_where_needed(parameters)
    tag_service_catalog_portfolios_where_needed(parameters)


def retrieve_default_accountwide_dbs_tag_values_from_ssm_parameters():
    parameter_descriptions = Tagger.ssm_client.describe_parameters(
        ParameterFilters=[{'Key': 'Name', 'Option': 'Contains', 'Values': [SSM_PARAM_PREFIX]}])
    params_request = list(map(lambda p: p['Name'], parameter_descriptions['Parameters']))
    params_resp = Tagger.ssm_client.get_parameters(Names=params_request)
    parameters = {}
    for param in params_resp['Parameters']:
        parameters.setdefault(param['Name'], param['Value'])
    return parameters


def tag_organization_root_if_needed(parameters):
    roots = Tagger.org_client.list_roots()
    root_id = roots['Roots'][0]['Id']
    add_missing_organization_resource_tags(root_id, parameters)
    return root_id


def tag_orgnizational_units_where_needed(parameters, root_id):
    org_units = Tagger.org_client.list_organizational_units_for_parent(ParentId=root_id)
    process_organization_units_level_for_tag_updates(org_units, parameters)


def process_organization_units_level_for_tag_updates(org_units, parameters):
    for org_unit in org_units['OrganizationalUnits']:
        add_missing_organization_resource_tags(org_unit['Id'], parameters)
        child_orgs = Tagger.org_client.list_organizational_units_for_parent(ParentId=org_unit['Id'])
        if len(child_orgs) > 0:
            process_organization_units_level_for_tag_updates(child_orgs, parameters)


def tag_organizational_accounts_where_needed(parameters):
    accounts = Tagger.org_client.list_accounts()
    for account in accounts['Accounts']:
        add_missing_organization_resource_tags(account['Id'], parameters)


def tag_service_control_policies_where_needed(parameters):
    policies = Tagger.org_client.list_policies(Filter='SERVICE_CONTROL_POLICY')
    for policy in policies['Policies']:
        if (policy['AwsManaged'] == False):
            add_missing_organization_resource_tags(policy['Id'], parameters)


def tag_service_catalog_products_where_needed(parameters):
    products = Tagger.service_catalog_client.search_products_as_admin()
    for product in products['ProductViewDetails']:
        id = product['ProductViewSummary']['ProductId']
        product_details = Tagger.service_catalog_client.describe_product_as_admin(Id=id)
        add_missing_service_catalog_resource_tags(id, product_details['Tags'], parameters, True)


def tag_service_catalog_portfolios_where_needed(parameters):
    portfolios = Tagger.service_catalog_client.list_portfolios()
    for portfolio in portfolios['PortfolioDetails']:
        id = portfolio['Id']
        portfolio_details = Tagger.service_catalog_client.describe_portfolio(Id=id)
        add_missing_service_catalog_resource_tags(id, portfolio_details['Tags'], parameters, False)


def add_missing_organization_resource_tags(resource_id, parameters):
    try:
        tags_resp = Tagger.org_client.list_tags_for_resource(ResourceId=resource_id)
        tags = tags_resp['Tags']
        for dbs_tag, tag_config in DBS_STANDARD_TAGS.items():
            if not any(tag['Key'] == dbs_tag for tag in tags):
                use_value = calc_value_to_use(parameters, tag_config)
                Tagger.org_client.tag_resource(ResourceId=resource_id, Tags=[{'Key': dbs_tag, 'Value': use_value}])
                LOGGER.info("Tagged %s with %s=%s", resource_id, dbs_tag, use_value)
    except botocore.exceptions.ClientError as error:
        LOGGER.warning("Error tagging organization resource: %s %s", resource_id, error.response["Error"])


def add_missing_service_catalog_resource_tags(id, tags, parameters, is_product):
    try:
        for dbs_tag, tag_config in DBS_STANDARD_TAGS.items():
            if not any(tag['Key'] == dbs_tag for tag in tags):
                use_value = calc_value_to_use(parameters, tag_config)
                if is_product:
                    Tagger.service_catalog_client.update_product(Id=id, AddTags=[{'Key': dbs_tag, 'Value': use_value}])
                else:
                    Tagger.service_catalog_client.update_portfolio(Id=id, AddTags=[{'Key': dbs_tag, 'Value': use_value}])
                LOGGER.info("Tagged %s with %s=%s", id, dbs_tag, use_value)
    except botocore.exceptions.ClientError as error:
        LOGGER.warning("Error tagging service catalog resource: %s %s", id, error.response["Error"])


def calc_value_to_use(parameters, tag_config):
    use_value = tag_config[1]
    if tag_config[0] != "":
        parameter = parameters[tag_config[0]]
        if parameter != None:
            use_value = parameter
    return use_value
