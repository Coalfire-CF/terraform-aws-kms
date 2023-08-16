output "s3_key_arn" {
  value = aws_kms_key.s3_key.arn
  description = "The arn of the s3 kms key"
}

output "ebs_key_arn" {
  value = aws_kms_key.ebs_key.arn
  description = "The arn of the ebs kms key"
}

output "lambda_key_arn" {
  value = aws_kms_key.lambda_key.arn
  description = "The arn of the lambda kms key"
}

output "rds_key_arn" {
  value = aws_kms_key.rds_key.arn
  description = "The arn of the rds kms key"
}

output "sqs_key_arn" {
  value = aws_kms_key.sqs_key.arn
  description = "The arn of the sqs kms key"
}

output "k8s_key_arn" {
  value = aws_kms_key.k8s_key.arn
  description = "The arn of the k8s key"
}

output "secrets_manager_key_arn" {
  value = aws_kms_key.secrets_manager_key.arn
  description = "The arn of the secrets manager kms key"
}

output "dynamo_key_arn" {
  value = aws_kms_key.dynamo_key.arn
  description = "The arn of the dynamodb kms key"
}

output "backup_key_arn" {
  value = aws_kms_key.backup_key.arn
  description = "The arn of the AWS Backup kms key"
}

output "s3_key_id" {
  value = aws_kms_key.s3_key.id
  description = "The id of the s3 key"
}

output "ebs_key_id" {
  value = aws_kms_key.ebs_key.id
  description = "The id of the ebs key"
}

output "lambda_key_id" {
  value = aws_kms_key.lambda_key.id
  description = "The id of the lambda key"
}

output "rds_key_id" {
  value = aws_kms_key.rds_key.id
  description = "The id of the rds key"
}

output "sqs_key_id" {
  value = aws_kms_key.sqs_key.id
  description = "The id of the sqs key"
}

output "k8s_key_id" {
  value = aws_kms_key.k8s_key.id
  description = "The id of the k8s key"
}

output "secrets_manager_key_id" {
  value = aws_kms_key.secrets_manager_key.id
  description = "The id of the secrets manager key"
}

output "dynamo_key_id" {
  value = aws_kms_key.dynamo_key.id
  description = "The id of the dynamodb key"
}

output "backup_key_id" {
  value = aws_kms_key.backup_key.id
  description = "The id of the AWS Backup key"
}
