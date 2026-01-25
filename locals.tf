locals {
  cmk_description = var.key_description != "" ? var.key_description : "${var.kms_key_resource_type} key for ${var.resource_prefix}"

  internal_tags = merge(var.tags, {
    Managed-by = "Terraform"
    Module     = "terraform-aws-kms"
  })
}