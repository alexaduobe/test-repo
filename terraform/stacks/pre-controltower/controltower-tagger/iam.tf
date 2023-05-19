data "aws_iam_policy_document" "manage_org" {
  statement {
    sid    = "SSMParametersLookup"
    effect = "Allow"
    actions = [
      "ssm:DescribeParameters",
      "ssm:GetParameters",
    ]
    resources = [
      "arn:aws:ssm:${data.aws_region.current.name}:${local.account_id}:*",
    ]
  }
  statement {
    sid    = "LambdaLogging"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${local.account_id}*",
    ]
  }
  statement {
    sid    = "GetResourcesToTag"
    effect = "Allow"
    actions = [
      "organizations:ListRoots",
      "organizations:ListAccounts",
      "organizations:ListPolicies",
      "servicecatalog:SearchProductsAsAdmin",
    ]
    resources = ["*"]
  }
  statement {
    sid    = "OrganizationTagging"
    effect = "Allow"
    actions = [
      "organizations:DescribeOrganizationalUnit",
      "organizations:ListOrganizationalUnitsForParent",
      "organizations:DescribeAccount",
      "organizations:ListTagsForResource",
      "organizations:TagResource",
    ]
    resources = [
      "arn:aws:organizations::${local.account_id}*",
    ]
  }
  statement {
    sid    = "ServiceCatalogTagging"
    effect = "Allow"
    actions = [
      "servicecatalog:DescribeProductAsAdmin",
      "servicecatalog:UpdateProduct",
      "servicecatalog:ListPortfolios",
      "servicecatalog:DescribePortfolio",
      "servicecatalog:UpdatePortfolio",
    ]
    resources = [
      "arn:aws:servicecatalog:${data.aws_region.current.name}:${local.account_id}*",
      "arn:aws:catalog:${data.aws_region.current.name}:${local.account_id}*",
    ]
  }
  statement {
    sid    = "EventBridge"
    effect = "Allow"
    actions = [
      "events:PutRule",
      "events:PutEvents",
    ]
    resources = [
      "arn:aws:events:${data.aws_region.current.name}:${local.account_id}*",
    ]
  }
}
