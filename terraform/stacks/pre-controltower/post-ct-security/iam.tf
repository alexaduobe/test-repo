data "aws_iam_policy_document" "manage_org" {
  statement {
    sid    = "OrganizationsAccess"
    effect = "Allow"
    actions = [
      "organizations:AttachPolicy",
      "organizations:CreatePolicy",
      "organizations:DescribeAccount",
      "organizations:DescribeEffectivePolicy",
      "organizations:DescribeOrganization",
      "organizations:DescribeOrganizationalUnit",
      "organizations:EnableAWSServiceAccess",
      "organizations:EnableAllFeatures",
      "organizations:EnablePolicyType",
      "organizations:ListAccounts",
      "organizations:ListAWSServiceAccessForOrganization",
      "organizations:ListDelegatedAdministrators",
      "organizations:ListPolicies",
      "organizations:ListRoots",
      "organizations:RegisterDelegatedAdministrator",
    ]
    resources = ["*"]
  }
  statement {
    sid    = "SecurityServices"
    effect = "Allow"
    actions = [
      "iam:CreateServiceLinkedRole",
      "ec2:DescribeRegions",
      "fms:AssociateAdminAccount",
      "guardduty:EnableOrganizationAdminAccount",
      "macie2:EnableMacie",
      "macie2:EnableOrganizationAdminAccount",
      "ram:EnableSharingWithAwsOrganization",
      "securityhub:EnableOrganizationAdminAccount",
      "servicecatalog:EnableAWSOrganizationsAccess",
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AssumeControlTowerExecution"
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:iam::*:role/AWSControlTowerExecution",
    ]
  }
}
