resource "aws_kms_key" "s3_key" {
  count = var.create_s3_key ? 1 : 0
  description         = "s3 key for ${var.resource_prefix}"
  policy                  = data.aws_iam_policy_document.s3_key.json
  enable_key_rotation = true
}

resource "aws_kms_alias" "s3_key_alias" {
  count = var.create_s3_key ? 1 : 0
  name          = "alias/${var.resource_prefix}-s3"
  target_key_id = aws_kms_key.s3_key.key_id
}


resource "aws_kms_key" "ebs_key" {
  count = var.create_ebs_key ? 1 : 0
  description         = "ebs key for ${var.resource_prefix}"
  policy = data.aws_iam_policy_document.ebs_key.json
  enable_key_rotation = true
}

resource "aws_kms_alias" "ebs_key_alias" {
  count = var.create_ebs_key ? 1 : 0
  name          = "alias/${var.resource_prefix}-ebs"
  target_key_id = aws_kms_key.ebs_key.key_id
}


resource "aws_kms_key" "rds_key" {
  count = var.create_rds_key ? 1 : 0
  description         = "rds key for ${var.resource_prefix}"
  enable_key_rotation = true
}

resource "aws_kms_alias" "rds_key_alias" {
  count = var.create_rds_key ? 1 : 0
  name          = "alias/${var.resource_prefix}-rds"
  target_key_id = aws_kms_key.rds_key.key_id
}


resource "aws_kms_key" "sqs_key" {
  count = var.create_sqs_key ? 1 : 0
  description         = "sqs key for ${var.resource_prefix}"
  enable_key_rotation = true
}

resource "aws_kms_alias" "sqs_key_alias" {
  count = var.create_sqs_key ? 1 : 0
  name          = "alias/${var.resource_prefix}-sqs"
  target_key_id = aws_kms_key.sqs_key.key_id
}

resource "aws_kms_key" "lambda_key" {
  count = var.create_lambda_key ? 1 : 0
  description         = "lambda key for ${var.resource_prefix}"
  enable_key_rotation = true
}

resource "aws_kms_alias" "lambda_key_alias" {
  count = var.create_lambda_key ? 1 : 0
  name          = "alias/${var.resource_prefix}-lambda"
  target_key_id = aws_kms_key.lambda_key.key_id
}

resource "aws_kms_key" "secrets_manager_key" {
  count = var.create_sm_key ? 1 : 0
  description         = "AWS Secrets Manager key for ${var.resource_prefix}"
  policy = data.aws_iam_policy_document.secrets_manager_key.json
  enable_key_rotation = true
}

resource "aws_kms_alias" "secrets_manager_alias" {
  count = var.create_sm_key ? 1 : 0
  name          = "alias/${var.resource_prefix}-secrets-manager"
  target_key_id = aws_kms_key.secrets_manager_key.key_id
}

resource "aws_kms_key" "dynamo_key" {
  count = var.create_dynamo_key ? 1 : 0
  description         = "Dynamo DB key for ${var.resource_prefix}"
  enable_key_rotation = true
}

resource "aws_kms_alias" "dynamo_alias" {
  count = var.create_dynamo_key ? 1 : 0
  name          = "alias/${var.resource_prefix}-dynamo-db"
  target_key_id = aws_kms_key.dynamo_key.key_id
}

resource "aws_kms_key" "backup_key" {
  count = var.create_backup_key ? 1 : 0
  description         = "AWS Backup key for ${var.resource_prefix}"
  policy                  = data.aws_iam_policy_document.s3_key.json
  enable_key_rotation = true
}

resource "aws_kms_alias" "backup_key_alias" {
  count = var.create_backup_key ? 1 : 0
  name          = "alias/${var.resource_prefix}-backup"
  target_key_id = aws_kms_key.backup_key.key_id
}

resource "aws_kms_key" "k8s_key" {
  count = var.create_k8s_key ? 1 : 0
  description         = "k8s key for ${var.resource_prefix}"
  policy                  = data.aws_iam_policy_document.k8s_key.json
  enable_key_rotation = true
}

resource "aws_kms_alias" "k8s_alias" {
  count = var.create_k8s_key ? 1 : 0
  name          = "alias/${var.resource_prefix}-k8s"
  target_key_id = aws_kms_key.k8s_key.key_id
}

data "aws_iam_policy_document" "s3_key" {

  dynamic "statement" {
    for_each = var.application_account_numbers
    content {
      effect = "Allow"
      actions = [
        "kms:*"]
      resources = [
        "*"]
      principals {
        identifiers = [
          "arn:${var.partition}:iam::${statement.value}:root"]
        type = "AWS"
      }
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:*"]
    resources = [
      "*"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:${var.partition}:iam::${var.account_number}:root"]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]
    resources = [
      "*"]

    principals {
      type = "Service"
      identifiers = [
        "delivery.logs.amazonaws.com"]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]
    resources = [
      "*"]

    principals {
      type = "Service"
      identifiers = [
        "logs.${var.default_aws_region}.amazonaws.com"]
    }
  }

  statement {
    sid = "Enable CloudTrail Encrypt Permissions"
    effect = "Allow"
    actions = [
      "kms:GenerateDataKey*"]
    resources = [
      "*"]
    condition {
      test = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values = [
        "arn:${var.partition}:cloudtrail:*:${var.account_number}:trail/*"]
    }
    principals {
      type = "Service"
      identifiers = [
        "cloudtrail.amazonaws.com"]
    }
  }

  dynamic "statement" {
    for_each = var.application_account_numbers
    content {
      effect = "Allow"
      actions = [
        "kms:GenerateDataKey*"]
      resources = [
        "*"]
      condition {
        test = "StringLike"
        variable = "kms:EncryptionContext:aws:cloudtrail:arn"
        values = [
          "arn:${var.partition}:cloudtrail:*:${statement.value}:trail/*"]
      }
      principals {
        type = "Service"
        identifiers = [
          "cloudtrail.amazonaws.com"]
      }
    }
  }
}

data "aws_iam_policy_document" "ebs_key" {

  statement {
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:${var.partition}:iam::${var.account_number}:root"
      ]
    }
  }
  dynamic "statement" {
    for_each = var.application_account_numbers
    content {
      effect = "Allow"
      actions = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey",
        "kms:CreateGrant",
        "kms:ListGrants",
        "kms:RevokeGrant"]
      resources = [
        "*"]
      principals {
        type = "AWS"
        identifiers = [
          "arn:${var.partition}:iam::${statement.value}:root"]
      }
    }
  }
      dynamic "statement" {
        for_each = var.application_account_numbers
        content {
          effect = "Allow"
          actions = [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:DescribeKey",
            "kms:CreateGrant",
            "kms:ListGrants"
          ]
          resources = [
            "*"]
          principals {
            type = "AWS"
            identifiers = [
              statement.value]
          }
          condition {
            test = "ArnEquals"
            values = ["aws:SourceArn"]
            variable = "arn:${var.partition}:iam::${statement.value}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
          }
        }
    }
}

data "aws_iam_policy_document" "secrets_manager_key" {
  dynamic "statement" {
    for_each = var.application_account_numbers
    content {
      effect = "Allow"
      actions = [
        "kms:*"]
      resources = [
        "*"]
      principals {
        identifiers = [
          "arn:${var.partition}:iam::${statement.value}:root"]
        type = "AWS"
      }
    }
  }

  statement {
    sid = "Enable MGMT IAM User Permissions"
    effect = "Allow"
    actions = ["kms:*"]
    principals {
      identifiers = ["arn:${var.partition}:iam::${var.account_number}:root"]
      type = "AWS"
    }
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "k8s_key" {
  dynamic "statement" {
    for_each = var.application_account_numbers
    content {
      effect = "Allow"
      actions = [
        "kms:*"]
      resources = [
        "*"]
      principals {
        identifiers = [
          "arn:${var.partition}:iam::${statement.value}:root"]
        type = "AWS"
      }
    }
  }

  statement {
    sid = "Enable MGMT IAM User Permissions"
    effect = "Allow"
    actions = ["kms:*"]
    principals {
      identifiers = ["arn:${var.partition}:iam::${var.account_number}:root"]
      type = "AWS"
    }
    resources = ["*"]
  }
}