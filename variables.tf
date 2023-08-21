variable "key_policy" {
  description = "IAM key policy for the kms key"
}

variable "kms_key_resource_type"{
  description = "the type of resource/service this key is for, such as S3, EBS or RDS"
}

variable "partition" {}

variable "account_number" {}

variable "application_account_numbers" {}

variable "default_aws_region" {}

variable "resource_prefix" {}