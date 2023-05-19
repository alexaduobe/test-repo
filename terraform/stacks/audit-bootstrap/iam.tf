resource "aws_iam_openid_connect_provider" "bitbucket" {
  url = "https://api.bitbucket.org/2.0/workspaces/DBSDEVMAN/pipelines-config/identity/oidc"
  client_id_list = [
    "ari:cloud:bitbucket::workspace/5c6e3881-7804-40d8-be56-c4472a6a74f4",
  ]
  thumbprint_list = [
    "a031c46782e6e6c662c2c87c76da9aa62ccabd8e",
  ]

  tags = module.this.tags
}

data "aws_iam_policy_document" "infrastructure" {
  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.bitbucket.arn]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "api.bitbucket.org/2.0/workspaces/DBSDEVMAN/pipelines-config/identity/oidc:repositoryUuid"
      values   = local.infrastructure_repo_uuids
    }
  }
}

resource "aws_iam_role" "infrastructure" {
  assume_role_policy = data.aws_iam_policy_document.infrastructure.json
  name               = local.infcicd_name

  tags = merge(module.this.tags, {
    Name = local.infcicd_name
  })
}

resource "aws_iam_role_policy_attachment" "infrastructure" {
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.infrastructure.name
}
