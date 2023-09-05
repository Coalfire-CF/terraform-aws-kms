<div align="center">
<img src="coalfire_logo.png" width="200">

</div>

## ACE-AWS-KMS

## Dependencies

Any resources requiring KMS keys

## Resource List

Insert a high-level list of resources created as a part of this module. E.g.

- Storage Account
- Containers
- Storage share
- Lifecycle policy
- CMK key and Iam Role Assignment
- Monitor diagnostic setting

## Code Updates

## Deployment Steps

This module can be called as outlined below.

- Change directories to the `kms` directory.
- From the `terraform/aws/kms` directory run `terraform init`.
- Run `terraform plan` to review the resources being created.
- If everything looks correct in the plan output, run `terraform apply`.

## Usage

Include example for how to call the module below with generic variables

```hcl
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "=4.58"
    }
  }
}

module "kms" {
  source                    = "github.com/Coalfire-CF/ACE-AWS-KMS?ref=vX.X.X"
  resource_prefix = var.resource_prefix
  kms_key_resource_type = "s3"
  key policy = data.aws_iam_policy_document.s3_kms_policy.json
}

data "aws_iam_policy_document" "s3_kms_policy" {
  statement {
    sid       = "source-account-full-access"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.mgmt_account_id}:root"]
    }
  }
  statement {
    sid    = "target-account-allow-grant"
    effect = "Allow"
    # the following actions are required by Terraform to read/create/remove grants
    actions = [
      "kms:CreateGrant",
      "kms:DescribeKey",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]
    resources = ["*"]
    # This allows any IAM role in the target account that has permission to create the grant to create the grant.
    # Can lock this down to a specific account in the target account so only that role is able to create grant for this key
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.app_account_id}:root"]
    }
  }
       
  # Resources
  resource "aws_kms_grant" "cross-account-grant" {
  name              = "grant-s3-kms-key"
  key_id            = module.kms.arn # key above that was deployed
  grantee_principal = data.aws_iam_role.my_role.arn #cross-account role you want to grant to 
  operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]
}
        
}


```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.kms_key_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_key_policy"></a> [key\_policy](#input\_key\_policy) | IAM key policy for the kms key | `any` | n/a | yes |
| <a name="input_kms_key_resource_type"></a> [kms\_key\_resource\_type](#input\_kms\_key\_resource\_type) | the type of resource/service this key is for, such as S3, EBS or RDS | `string` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | The prefix for the KMS key alias | `string` | n/a | yes |
| <a name="input_key_description"></a> [key_description](#input\_key_description) | This overwrites the default generated description for the KMS key. | `string` | n/a | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | The arn of the s3 kms key |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | The id of the s3 key |
<!-- END_TF_DOCS -->

## Contributing

[Relative or absolute link to contributing.md](CONTRIBUTING.md)


## License

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/license/mit/)


## Coalfire Pages

[Absolute link to any relevant Coalfire Pages](https://coalfire.com/)

### Copyright

Copyright © 2023 Coalfire Systems Inc.
