![Coalfire](coalfire_logo.png)

# terraform-aws-kms

## Description

This module creates AWS KMS keys and aliases for encrypting resources with full customization of key policies and automatic handling of AWS partitions. It supports both commercial and GovCloud environments and follows AWS security best practices, including automatic key rotation.

The module supports various AWS services by allowing customization of the key purpose, tagging, and access policies. 

Keys created by this module can be used for S3 buckets, EBS volumes, RDS databases, and other AWS services requiring encryption.
FedRAMP Compliance: Moderate, High

## Dependencies

Internal Modules:
No prerequisite modules are required to deploy this module.

AWS Provider 5.0+
IAM permissions to create and manage KMS resources.

## Resource List

AWS KMS Key with customizable policy and automatic key rotation
AWS KMS Alias for easier key identification and management
Automatic AWS partition detection for commercial and GovCloud environments

## Usage

```hcl
module "kms" {
   source                = "git::https://github.com/Coalfire-CF/terraform-aws-kms.git?ref=vx.x.x"
   resource_prefix       = var.resource_prefix
   kms_key_resource_type = "s3"
   key_policy            = data.aws_iam_policy_document.s3_kms_policy.json
}

data "aws_iam_policy_document" "s3_kms_policy" {
   statement {
      sid       = "source-account-full-access"
      effect    = "Allow"
      actions   = ["kms:*"]
      resources = ["*"]
      principals {
         type        = "AWS"
         identifiers = ["arn:aws-us-gov:iam::${var.mgmt_account_id}:root"]
      }
   }

   statement {
      sid     = "target-account-allow-grant"
      effect  = "Allow"
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
}

resource "aws_kms_grant" "cross-account-grant" {
   name              = "grant-s3-kms-key"
   key_id            = module.kms.arn # key above that was deployed
   grantee_principal = data.aws_iam_role.my_role.arn #cross-account role or resource/service role you want to grant to
   operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]
}
```

## Environment Setup

```hcl
IAM user authentication:

- Download and install the AWS CLI (https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- Log into the AWS Console and create AWS CLI Credentials (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)
- Configure the named profile used for the project, such as 'aws configure --profile example-mgmt'

SSO-based authentication (via IAM Identity Center SSO):

- Login to the AWS IAM Identity Center console, select the permission set for MGMT, and select the 'Access Keys' link.
- Choose the 'IAM Identity Center credentials' method to get the SSO Start URL and SSO Region values.
- Run the setup command 'aws configure sso --profile example-mgmt' and follow the prompts.
- Verify you can run AWS commands successfully, for example 'aws s3 ls --profile example-mgmt'.
- Run 'export AWS_PROFILE=example-mgmt' in your terminal to use the specific profile and avoid having to use '--profile' option.
```

## Deployment

Please note that the following steps are to be used as an example since this PAK module is deployed through other modules (such as Account Setup PAK), there isn't a need to call this module directly on builds.

1. Navigate to the Terraform project and create a parent directory in the upper level code, for example:

    ```hcl
    ../{CLOUD}/terraform/{REGION}/management-account/example
    ```

   If multi-account management plane:

    ```hcl
    ../{CLOUD}/terraform/{REGION}/{ACCOUNT_TYPE}-mgmt-account/example
    ```

2. Create a properly defined main.tf file via the template found under 'Usage' while adjusting tfvars as needed. Note that many provided variables are outputs from other modules. Example parent directory:

   ```hcl
   ├── Example/
   │   ├── userdata/
   │   │   ├── script.sh
   │   ├── example.auto.tfvars   
   │   ├── main.tf
   │   ├── outputs.tf
   │   ├── providers.tf
   │   ├── required-providers.tf
   │   ├── variables.tf
   │   ├── ...
   ```

3. Initialize the Terraform working directory:
   ```hcl
   terraform init
   ```
   Create an execution plan and verify the resources being created:
   ```hcl
   terraform plan
   ```
   Apply the configuration:
   ```hcl
   terraform apply
   ```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.10.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

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
| <a name="input_key_description"></a> [key\_description](#input\_key\_description) | The description given to the created CMK | `string` | `""` | no |
| <a name="input_key_policy"></a> [key\_policy](#input\_key\_policy) | IAM key policy for the kms key | `any` | `null` | no |
| <a name="input_kms_key_resource_type"></a> [kms\_key\_resource\_type](#input\_kms\_key\_resource\_type) | The type of resource/service this key is for, such as S3, EBS or RDS | `string` | n/a | yes |
| <a name="input_multi_region"></a> [multi\_region](#input\_multi\_region) | Indicates whether the KMS key is a multi-Region (true) or regional (false) key. | `bool` | `false` | no |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | The prefix of the KMS key alias | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. map(`BusinessUnit`,`XYZ`). | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | The arn of the s3 kms key |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | The id of the s3 key |
<!-- END_TF_DOCS -->

## Contributing

[Start Here](CONTRIBUTING.md)

## License

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/license/mit/)

## Contact Us

[Coalfire](https://coalfire.com/)

### Copyright

Copyright © 2023 Coalfire Systems Inc.

## Tree
```
.
|-- CONTRIBUTING.md
|-- LICENSE
|-- License.md
|-- README.md
|-- coalfire_logo.png
|-- locals.tf
|-- main.tf
|-- outputs.tf
|-- providers.tf
|-- release-please-config.json
|-- update-readme-tree.sh
|-- variables.tf
```
