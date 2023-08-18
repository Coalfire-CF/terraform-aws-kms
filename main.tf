resource "aws_kms_key" "s3_key" {
  count = var.create_s3_key ? 1 : 0
  description         = "s3 key for ${var.resource_prefix}"
  policy                  = var.s3_key_policy
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
  policy = var.ebs_key_policy
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
  policy = var.sm_key_policy
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
  policy                  = var.backup_key_policy
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
  policy                  = var.k8s_key_policy
  enable_key_rotation = true
}
