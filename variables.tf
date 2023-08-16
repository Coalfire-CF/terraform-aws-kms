variable "create_s3_key" {
  description = "flag to create s3 kms key"
}

variable "create_ebs_key" {
  description = "flag to create ebs kms key"
}

variable "create_k8s_key" {
  description = "flag to create k8s kms key"
}

variable "create_ecs_key" {
  description = "flag to create ecs kms key"
}

variable "create_backup_key" {
  description = "flag to create backup kms key"
}

variable "create_ecr_key" {
  description = "flag to create ecr kms key"
}

variable "create_dynamo_key" {
  description = "flag to create dynamic kms key"
}

variable "create_sm_key" {
  description = "flag to create sm kms key"
}

variable "create_rds_key" {
  description = "flag to create rds kms key"
}


variable "create_lambda_key" {
  description = "flag to create lambda kms key"
}

variable "create_sqs_key" {
  description = "flag to create sqs kms key"
}


variable "partition" {}

variable "account_number" {}

variable "application_account_numbers" {}

variable "default_aws_region" {}

variable "resource_prefix" {}