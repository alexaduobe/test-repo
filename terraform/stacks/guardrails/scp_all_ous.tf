resource "aws_organizations_policy" "scp_all_ous" {
  name        = "${module.this.name_prefix}-all"
  description = "Entire organization security disallows"
  content     = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DBSBILLINGMODIFICATION",
      "Effect": "Deny",
      "Action": [
        "aws-portal:ModifyAccount",
        "aws-portal:ModifyBilling",
        "aws-portal:ModifyPaymentMethods"
      ],
      "Resource": "*",
      "Condition": {
        "ArnNotLike": {
          "aws:PrincipalARN": "arn:aws:iam::*:root"
        }
      }
    },
    {
      "Sid": "DBSIAMUSERCREATE",
      "Effect": "Deny",
      "Action": [
        "iam:CreateUser",
        "iam:CreateAccessKey"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "DBSORGANIZATIONS",
      "Effect": "Deny",
      "Action": [
        "organizations:LeaveOrganization"
      ],
      "Resource": "*"
    },
    {
      "Sid": "DBSACCESSANALYZERDELETIONPROHIBITED",
      "Effect": "Deny",
      "Action": [
        "access-analyzer:DeleteAnalyzer"
      ],
      "Resource": "*",
      "Condition": {
        "ArnNotLike": {
          "aws:PrincipalARN":"arn:aws:iam::*:role/AWSControlTowerExecution"
        }
      }
    },
    {
      "Sid": "DBSGUARDDUTY",
      "Effect": "Deny",
      "Action": [
        "guardduty:DeleteDetector",
        "guardduty:DeleteInvitations",
        "guardduty:DeleteIPSet",
        "guardduty:DeleteMembers",
        "guardduty:DeleteThreatIntelSet",
        "guardduty:DisassociateFromMasterAccount",
        "guardduty:DisassociateMembers",
        "guardduty:StopMonitoringMembers",
        "guardduty:UpdateDetector"
      ],
      "Resource": "*"
    },
    {
      "Sid": "DBSMACIE",
      "Effect": "Deny",
      "Action": [
        "macie2:DisassociateFromMasterAccount",
        "macie2:DisableOrganizationAdminAccount",
        "macie2:DisableMacie",
        "macie2:DeleteMember"
      ],
      "Resource": "*"
    },
    {
      "Sid": "DBSSECURITYHUB",
      "Effect": "Deny",
      "Action": [
        "securityhub:DeleteInvitations",
        "securityhub:DisableSecurityHub",
        "securityhub:DisassociateFromMasterAccount",
        "securityhub:DeleteMembers",
        "securityhub:DisassociateMembers"
      ],
      "Resource": "*"
    }
  ]
}
POLICY

  tags = merge(module.this.tags, {
    Name = "${module.this.name_prefix}-all"
  })
}

resource "aws_organizations_policy_attachment" "scp_all_ous" {
  for_each = { for child in local.toplevel_ous : child.id => child }

  policy_id = aws_organizations_policy.scp_all_ous.id
  target_id = each.value.id
}
