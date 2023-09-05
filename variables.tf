variable "key_policy" {
  description = "IAM key policy for the kms key"
}

variable "kms_key_resource_type" {
  description = "the type of resource/service this key is for, such as S3, EBS or RDS"
  type        = string
}

variable "key_description" {
  description = "The description given to the created CMK"
  type        = string
  default     = ""
}

variable "resource_prefix" {
  description = "The prefix of the KMS Key Alias"
  type        = string
}