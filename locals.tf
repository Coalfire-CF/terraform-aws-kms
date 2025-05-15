locals {
  cmk_description = var.key_description != "" ? var.key_description : "${var.kms_key_resource_type} key for ${var.resource_prefix}"
  key_arn_pattern = "arn:${data.aws_partition.current.partition}:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/*"

  internal_tags = {

    Managed-by = "Terraform"
    Module     = "terraform-aws-kms"
  }

}