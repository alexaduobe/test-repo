from unittest.mock import MagicMock, patch
from tagger import *
import unittest
import json

class TestTagger(unittest.TestCase):
    fp = open('account_created_event.json')
    acct_created_event = json.load(fp)
    fp.close()
    lambda_context = {}
    # arrange
    ssm_param_names = [
        '/dbs/tagging/availability',
        '/dbs/tagging/codeowners',
        '/dbs/tagging/dataowners',
        '/dbs/tagging/environment',
        '/dbs/tagging/project',
        '/dbs/tagging/projectowners',
        '/dbs/tagging/projecttype',
    ]
    tag_values = [
        'always_on',
        'daughertylabs@daugherty.com',
        'daughertylabs@daugherty.com',
        'production',
        'DAUGHERTY 61777',
        'daughertylabs@daugherty.com',
        'NONBILL',
    ]
    root_id = 'root-123'
    org_units = {'OrganizationalUnits' : [{'Id': '1'}, {'Id': '2'}, {'Id': '3'}]}
    accounts = {'Accounts': [{'Id': '1'}, {'Id': '2'}]}
    policies = {'Policies': [{'Id': '1', 'AwsManaged': True}, {'Id': '2', 'AwsManaged': False}]}
    product_ids = ['Product1', 'Product2']
    products = {'ProductViewDetails': [
        {'ProductViewSummary': {'ProductId': product_ids[0]}},
        {'ProductViewSummary': {'ProductId': product_ids[1]}},
    ]}
    portfolio_ids = ['Portfolio1', 'Portfolio2']
    portfolios = {'PortfolioDetails': [{'Id': portfolio_ids[0]}, {'Id': portfolio_ids[1]}]}

    describe_params_mock = MagicMock()
    get_params_mock = MagicMock()
    list_roots_mock = MagicMock()
    list_org_tags_mock = MagicMock()
    tag_org_resource_mock = MagicMock()
    list_orgs_for_parent_mock = MagicMock()
    list_accounts_mock = MagicMock()
    list_policies_mock = MagicMock()
    search_products_mock = MagicMock()
    describe_product_mock = MagicMock()
    update_product_mock = MagicMock()
    list_portfolios_mock = MagicMock()
    describe_portfolio_mock = MagicMock()
    update_portfolio_mock = MagicMock()

    def ou_side_effect_func(ParentId):
        if TestTagger.root_id in ParentId:
            return TestTagger.org_units
        else:
            return {'OrganizationalUnits': []}
    
    def set_up_tests():
        TestTagger.describe_params_mock = MagicMock(return_value={"Parameters": [
            {'Name': TestTagger.ssm_param_names[0]},
            {'Name': TestTagger.ssm_param_names[1]},
            {'Name': TestTagger.ssm_param_names[2]},
            {'Name': TestTagger.ssm_param_names[3]},
            {'Name': TestTagger.ssm_param_names[4]},
            {'Name': TestTagger.ssm_param_names[5]},
            {'Name': TestTagger.ssm_param_names[6]},
        ]})
        TestTagger.get_params_mock = MagicMock(return_value={"Parameters": [
            {'Name': TestTagger.ssm_param_names[0], 'Value': TestTagger.tag_values[0]},
            {'Name': TestTagger.ssm_param_names[1], 'Value': TestTagger.tag_values[1]},
            {'Name': TestTagger.ssm_param_names[2], 'Value': TestTagger.tag_values[2]},
            {'Name': TestTagger.ssm_param_names[3], 'Value': TestTagger.tag_values[3]},
            {'Name': TestTagger.ssm_param_names[4], 'Value': TestTagger.tag_values[4]},
            {'Name': TestTagger.ssm_param_names[5], 'Value': TestTagger.tag_values[5]},
            {'Name': TestTagger.ssm_param_names[6], 'Value': TestTagger.tag_values[6]},
        ]})
        TestTagger.list_roots_mock = MagicMock(return_value={'Roots': [{'Id': TestTagger.root_id}]})
        TestTagger.list_org_tags_mock = MagicMock(return_value={'Tags': []})
        TestTagger.tag_org_resource_mock = MagicMock()
        TestTagger.list_orgs_for_parent_mock = MagicMock(side_effect=TestTagger.ou_side_effect_func)
        TestTagger.list_accounts_mock = MagicMock(return_value=TestTagger.accounts)
        TestTagger.list_policies_mock = MagicMock(return_value=TestTagger.policies)
        TestTagger.search_products_mock = MagicMock(return_value=TestTagger.products)
        TestTagger.describe_product_mock = MagicMock(return_value={'Tags': []})
        TestTagger.update_product_mock = MagicMock()
        TestTagger.list_portfolios_mock = MagicMock(return_value=TestTagger.portfolios)
        TestTagger.describe_portfolio_mock = MagicMock(return_value={'Tags': []})
        TestTagger.update_portfolio_mock = MagicMock()
    
        Tagger.ssm_client.describe_parameters = TestTagger.describe_params_mock
        Tagger.ssm_client.get_parameters = TestTagger.get_params_mock
        Tagger.org_client.list_roots = TestTagger.list_roots_mock
        Tagger.org_client.list_tags_for_resource = TestTagger.list_org_tags_mock
        Tagger.org_client.tag_resource = TestTagger.tag_org_resource_mock
        Tagger.org_client.list_organizational_units_for_parent = TestTagger.list_orgs_for_parent_mock
        Tagger.org_client.list_accounts = TestTagger.list_accounts_mock
        Tagger.org_client.list_policies = TestTagger.list_policies_mock
        Tagger.service_catalog_client.search_products_as_admin = TestTagger.search_products_mock
        Tagger.service_catalog_client.describe_product_as_admin = TestTagger.describe_product_mock
        Tagger.service_catalog_client.update_product = TestTagger.update_product_mock
        Tagger.service_catalog_client.list_portfolios = TestTagger.list_portfolios_mock
        Tagger.service_catalog_client.describe_portfolio = TestTagger.describe_portfolio_mock
        Tagger.service_catalog_client.update_portfolio = TestTagger.update_portfolio_mock
    
    def test_get_params(self):
        # arrange
        TestTagger.set_up_tests()
        # act
        handler(TestTagger.acct_created_event, TestTagger.lambda_context)
        # assert
        TestTagger.describe_params_mock.assert_called_once_with(ParameterFilters=[{'Key': 'Name', 'Option': 'Contains', 'Values': [SSM_PARAM_PREFIX]}])
        TestTagger.get_params_mock.assert_called_once_with(Names=TestTagger.ssm_param_names)

    def test_tag_root(self):
        # arrange
        TestTagger.set_up_tests()
        # act
        handler(TestTagger.acct_created_event, TestTagger.lambda_context)
        # assert
        TestTagger.list_roots_mock.assert_called_once()
        TestTagger.list_org_tags_mock.assert_any_call(ResourceId=TestTagger.root_id)
        for i in range(len(TestTagger.ssm_param_names)):
            TestTagger.tag_org_resource_mock.assert_any_call(ResourceId=TestTagger.root_id, Tags=[{'Key': 'dbs-' + TestTagger.ssm_param_names[i].split("/")[-1], 'Value': TestTagger.tag_values[i]}])
    
    def test_tag_OUs(self):
        # arrange
        TestTagger.set_up_tests()
        # act
        handler(TestTagger.acct_created_event, TestTagger.lambda_context)
        # assert
        self.assertEqual(TestTagger.list_orgs_for_parent_mock.call_count, len(TestTagger.org_units['OrganizationalUnits']) + 1)
        for i in range(len(TestTagger.org_units)):
            TestTagger.list_org_tags_mock.assert_any_call(ResourceId=TestTagger.org_units['OrganizationalUnits'][i]['Id'])
            for j in range(len(TestTagger.ssm_param_names)):
                TestTagger.tag_org_resource_mock.assert_any_call(ResourceId=TestTagger.org_units['OrganizationalUnits'][i]['Id'], Tags=[{'Key': 'dbs-' + TestTagger.ssm_param_names[j].split("/")[-1], 'Value': TestTagger.tag_values[j]}])

    def test_tag_accounts(self):
        # arrange
        TestTagger.set_up_tests()
        # act
        handler(TestTagger.acct_created_event, TestTagger.lambda_context)
        # assert
        TestTagger.list_accounts_mock.assert_called_once()
        for i in range(len(TestTagger.accounts)):
            TestTagger.list_org_tags_mock.assert_any_call(ResourceId=TestTagger.accounts['Accounts'][i]['Id'])
            for j in range(len(TestTagger.ssm_param_names)):
                TestTagger.tag_org_resource_mock.assert_any_call(ResourceId=TestTagger.accounts['Accounts'][i]['Id'], Tags=[{'Key': 'dbs-' + TestTagger.ssm_param_names[j].split("/")[-1], 'Value': TestTagger.tag_values[j]}])

    def test_tag_policies(self):
        # arrange
        TestTagger.set_up_tests()
        # act
        handler(TestTagger.acct_created_event, TestTagger.lambda_context)
        # assert
        TestTagger.list_policies_mock.assert_called_once_with(Filter='SERVICE_CONTROL_POLICY')
        taggedPolicies = list(filter(lambda p: p.get("AwsManaged") == False, TestTagger.policies['Policies']))
        for i in range(len(taggedPolicies)):
            TestTagger.list_org_tags_mock.assert_any_call(ResourceId=taggedPolicies[i]['Id'])
            for j in range(len(TestTagger.ssm_param_names)):
                TestTagger.tag_org_resource_mock.assert_any_call(ResourceId=taggedPolicies[i]['Id'], Tags=[{'Key': 'dbs-' + TestTagger.ssm_param_names[j].split("/")[-1], 'Value': TestTagger.tag_values[j]}])
    
    def test_tag_products(self):
        # arrange
        TestTagger.set_up_tests()
        # act
        handler(TestTagger.acct_created_event, TestTagger.lambda_context)
        # assert
        TestTagger.search_products_mock.assert_called_once()
        for i in range(len(TestTagger.products)):
            product_id = TestTagger.products['ProductViewDetails'][i]['ProductViewSummary']['ProductId']
            TestTagger.describe_product_mock.assert_any_call(Id=product_id)
            for j in range(len(TestTagger.ssm_param_names)):
                TestTagger.update_product_mock.assert_any_call(Id=product_id, AddTags=[{'Key': 'dbs-' + TestTagger.ssm_param_names[j].split("/")[-1], 'Value': TestTagger.tag_values[j]}])

    def test_tag_portfolios(self):
        # arrange
        TestTagger.set_up_tests()
        # act
        handler(TestTagger.acct_created_event, TestTagger.lambda_context)
        # assert
        TestTagger.list_portfolios_mock.assert_called_once()
        for i in range(len(TestTagger.portfolios)):
            portfolio_id = TestTagger.portfolios['PortfolioDetails'][i]['Id']
            TestTagger.describe_portfolio_mock.assert_any_call(Id=portfolio_id)
            for j in range(len(TestTagger.ssm_param_names)):
                TestTagger.update_portfolio_mock.assert_any_call(Id=portfolio_id, AddTags=[{'Key': 'dbs-' + TestTagger.ssm_param_names[j].split("/")[-1], 'Value': TestTagger.tag_values[j]}])