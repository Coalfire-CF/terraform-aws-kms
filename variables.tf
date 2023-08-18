variable "create_s3_key" {
  description = "flag to create s3 kms key"
}

variable "s3_key_policy" {
  description = "IAM key policy for S3 key"
}

variable "create_ebs_key" {
  description = "flag to create ebs kms key"
}

variable "ebs_key_policy" {
  description = "IAM key policy for EBS key"
}

variable "create_k8s_key" {
  description = "flag to create k8s kms key"
}

variable "k8s_key_policy" {
  description = "IAM key policy for K8S key"
}

variable "create_ecs_key" {
  description = "flag to create ecs kms key"
}

variable "ecs_key_policy" {
  description = "IAM key policy for ecs key"
}

variable "create_backup_key" {
  description = "flag to create backup kms key"
}

variable "backup_key_policy" {
    description = "IAM key policy for backup key"
}

variable "create_ecr_key" {
  description = "flag to create ecr kms key"
}

variable "ecr_key_policy" {
    description = "IAM key policy for ecr key"
}

variable "create_dynamo_key" {
  description = "flag to create dynamic kms key"
}

variable "dynamo_key_policy" {
    description = "IAM key policy for dynamo key"
}

variable "create_sm_key" {
  description = "flag to create sm kms key"
}

variable "sm_key_policy" {
    description = "IAM key policy for secrets manager key"

}

variable "create_rds_key" {
  description = "flag to create rds kms key"
}

variable "rds_key_policy" {
  description = "IAM key policy for rds key"
}

variable "create_lambda_key" {
  description = "flag to create lambda kms key"
}

variable "lambda_key_policy" {
  description = "IAM key policy for lambda key"
}

variable "create_sqs_key" {
  description = "flag to create sqs kms key"
}

variable "sqs_key_policy" {
  description = "IAM key policy for sqs key"
}

variable "partition" {}

variable "account_number" {}

variable "application_account_numbers" {}

variable "default_aws_region" {}

variable "resource_prefix" {}