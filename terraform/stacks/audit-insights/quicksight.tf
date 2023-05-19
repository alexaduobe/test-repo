resource "aws_glue_catalog_database" "logarchivedatabase" {
  name = "logarchive"
}

data "template_file" "athena_create_table" {
  template = file("${path.module}/Athena/CreateTableTemplate.sql")
  vars = {
    s3_location = aws_s3_bucket.cloudtrail_logs.bucket
  }
}

resource "local_file" "athena_file_create_table" {
  content  = data.template_file.athena_create_table.rendered
  filename = "${path.module}/LocalOutput/CreateTable.sql"
}

resource "aws_athena_named_query" "createtable" {
  name      = "CreateCloudTrailTable"
  workgroup = "primary"
  database  = aws_glue_catalog_database.logarchivedatabase.name
  query     = data.template_file.athena_create_table.rendered
}
resource "null_resource" "run_athena_query_to_create_table" {
  depends_on = [
    aws_athena_named_query.createtable
  ]
  provisioner "local-exec" {
    command = <<EOF
    aws athena start-query-execution  --query-string file://LocalOutput/CreateTable.sql --work-group ${aws_athena_named_query.createtable.workgroup} --query-execution-context Database=${aws_athena_named_query.createtable.database},Catalog=AwsDataCatalog --result-configuration OutputLocation=${aws_s3_bucket.athena_queries.bucket}
EOF
  }
}
resource "aws_athena_named_query" "total_api_requests" {
  name      = "TotalApiRequests"
  workgroup = "primary"
  database  = aws_glue_catalog_database.logarchivedatabase.name
  query     = file("${path.module}/Athena/TotalApiRequestsQuery.sql")
}

resource "aws_athena_named_query" "top_ten_services" {
  name      = "TopTenServices"
  workgroup = "primary"
  database  = aws_glue_catalog_database.logarchivedatabase.name
  query     = file("${path.module}/Athena/TopTenServicesQuery.sql")
}

resource "aws_athena_named_query" "top_ten_accounts" {
  name      = "TopTenAccounts"
  workgroup = "primary"
  database  = aws_glue_catalog_database.logarchivedatabase.name
  query     = file("${path.module}/Athena/TopTenAccountsQuery.sql")
}

resource "aws_athena_named_query" "top_ten_users" {
  name      = "TopTenUsers"
  workgroup = "primary"
  database  = aws_glue_catalog_database.logarchivedatabase.name
  query     = file("${path.module}/Athena/TopTenUsersQuery.sql")
}

data "template_file" "quicksight_datasource_template" {
  template = file("${path.module}/QuickSight/CreateDataSourceTemplate.json")
  vars = {
    account_id    = local.account_id
    datasource_id = local.datasource_id
  }
}

data "template_file" "quicksight_dataset_template_apirequests" {
  template = file("${path.module}/QuickSight/TotalApiRequestsDatasetTemplate.json")
  vars = {
    account_id    = local.account_id
    principal     = local.principal_arn
    dataset_id    = local.dataset_id_api_requests
    datasource_id = local.datasource_id
  }
}

data "template_file" "quicksight_dataset_template_toptenservices" {
  template = file("${path.module}/QuickSight/TopTenServicesDatasetTemplate.json")
  vars = {
    account_id    = local.account_id
    principal     = local.principal_arn
    dataset_id    = local.dataset_id_services
    datasource_id = local.datasource_id
  }
}

data "template_file" "quicksight_dataset_template_toptenaccounts" {
  template = file("${path.module}/QuickSight/TopTenAccountsDatasetTemplate.json")
  vars = {
    account_id    = local.account_id
    principal     = local.principal_arn
    dataset_id    = local.dataset_id_accounts
    datasource_id = local.datasource_id
  }
}

data "template_file" "quicksight_dataset_template_toptenusers" {
  template = file("${path.module}/QuickSight/TopTenUsersDatasetTemplate.json")
  vars = {
    account_id    = local.account_id
    principal     = local.principal_arn
    dataset_id    = local.dataset_id_users
    datasource_id = local.datasource_id
  }
}

data "template_file" "quicksight_dashboard_template" {
  template = file("${path.module}/QuickSight/CreateDashboardTemplate.json")
  vars = {
    account_id              = local.account_id
    principal               = local.principal_arn
    dataset_id_accounts     = local.dataset_id_accounts
    dataset_id_api_requests = local.dataset_id_api_requests
    dataset_id_services     = local.dataset_id_services
    dataset_id_users        = local.dataset_id_users
  }
}
resource "local_file" "quicksight_datasource_file" {
  content  = data.template_file.quicksight_datasource_template.rendered
  filename = "${path.module}/LocalOutput/CreateDataSource.json"
}

resource "local_file" "quicksight_dataset_file_apirequests" {
  content  = data.template_file.quicksight_dataset_template_apirequests.rendered
  filename = "${path.module}/LocalOutput/TotalApiRequestsDataset.json"
}

resource "local_file" "quicksight_dataset_file_toptenservices" {
  content  = data.template_file.quicksight_dataset_template_toptenservices.rendered
  filename = "${path.module}/LocalOutput/TopTenServicesDataset.json"
}

resource "local_file" "quicksight_dataset_file_toptenaccounts" {
  content  = data.template_file.quicksight_dataset_template_toptenaccounts.rendered
  filename = "${path.module}/LocalOutput/TopTenAccountsDataset.json"
}

resource "local_file" "quicksight_dataset_file_toptenusers" {
  content  = data.template_file.quicksight_dataset_template_toptenusers.rendered
  filename = "${path.module}/LocalOutput/TopTenUsersDataset.json"
}

resource "local_file" "quicksight_dashboard_file_template" {
  content  = data.template_file.quicksight_dashboard_template.rendered
  filename = "${path.module}/LocalOutput/CreateDashboard.json"
}

resource "null_resource" "delete_quicksight_datasource" {
  count = var.delete != false ? 1 : 0
  provisioner "local-exec" {
    command = "aws quicksight delete-data-source --aws-account-id ${local.account_id} --data-source-id ${local.datasource_id}"
  }
}

resource "null_resource" "delete_quicksight_dataset_total_api_requests" {
  count = var.delete != false ? 1 : 0
  provisioner "local-exec" {
    command = "aws quicksight delete-data-set --aws-account-id ${local.account_id} --data-set-id ${local.dataset_id_api_requests}"
  }
}

resource "null_resource" "delete_quicksight_dataset_top_ten_services" {
  count = var.delete != false ? 1 : 0
  provisioner "local-exec" {
    command = "aws quicksight delete-data-set --aws-account-id ${local.account_id} --data-set-id ${local.dataset_id_services}"
  }
}

resource "null_resource" "delete_quicksight_dataset_top_ten_accounts" {
  count = var.delete != false ? 1 : 0
  provisioner "local-exec" {
    command = "aws quicksight delete-data-set --aws-account-id ${local.account_id} --data-set-id ${local.dataset_id_accounts}"
  }
}

resource "null_resource" "delete_quicksight_dataset_top_ten_users" {
  count = var.delete != false ? 1 : 0
  provisioner "local-exec" {
    command = "aws quicksight delete-data-set --aws-account-id ${local.account_id} --data-set-id ${local.dataset_id_users}"
  }
}

resource "null_resource" "delete_quicksight_dashboard" {
  count = var.delete != false ? 1 : 0
  provisioner "local-exec" {
    command = "aws quicksight delete-dashboard --aws-account-id ${local.account_id} --dashboard-id ${jsondecode(file("${path.module}/QuickSight/CreateDashboardTemplate.json")).DashboardId}"
  }
}

resource "null_resource" "create_quicksight_datasource" {
  provisioner "local-exec" {
    command = "aws quicksight create-data-source --cli-input-json file://LocalOutput/CreateDataSource.json"
  }
  depends_on = [null_resource.delete_quicksight_datasource]
}

resource "null_resource" "create_quicksight_dataset_total_api_requests" {
  provisioner "local-exec" {
    command = "aws quicksight create-data-set --cli-input-json file://LocalOutput/TotalApiRequestsDataset.json"
  }
  depends_on = [null_resource.delete_quicksight_dataset_total_api_requests]
}

resource "null_resource" "create_quicksight_dataset_top_ten_services" {
  provisioner "local-exec" {
    command = "aws quicksight create-data-set --cli-input-json file://LocalOutput/TopTenServicesDataset.json"

  }
  depends_on = [null_resource.delete_quicksight_dataset_top_ten_services]
}

resource "null_resource" "create_quicksight_dataset_top_ten_accounts" {
  provisioner "local-exec" {
    command = "aws quicksight create-data-set --cli-input-json file://LocalOutput/TopTenAccountsDataset.json"

  }
  depends_on = [null_resource.delete_quicksight_dataset_top_ten_accounts]
}

resource "null_resource" "create_quicksight_dataset_top_ten_users" {
  provisioner "local-exec" {
    command = "aws quicksight create-data-set --cli-input-json file://LocalOutput/TopTenUsersDataset.json"

  }
  depends_on = [null_resource.delete_quicksight_dataset_top_ten_users]
}

resource "null_resource" "create_quicksight_dashboard" {
  provisioner "local-exec" {
    command = "aws quicksight create-dashboard --cli-input-json file://LocalOutput/CreateDashboard.json"

  }
  depends_on = [
    null_resource.delete_quicksight_dashboard,
    null_resource.create_quicksight_dataset_total_api_requests,
    null_resource.create_quicksight_dataset_top_ten_services,
    null_resource.create_quicksight_dataset_top_ten_accounts,
    null_resource.create_quicksight_dataset_top_ten_users
  ]
}

