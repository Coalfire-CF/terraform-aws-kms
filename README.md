![Coalfire](coalfire_logo.png)


# terraform-aws-kms


## Description

This module creates AWS KMS keys and aliases for encrypting resources with full customization of key policies and automatic handling of AWS partitions. It supports both commercial and GovCloud environments and follows AWS security best practices, including automatic key rotation.

The module supports various AWS services by allowing customization of the key purpose, tagging, and access policies. 

Keys created by this module can be used for S3 buckets, EBS volumes, RDS databases, and other AWS services requiring encryption.
FedRAMP Compliance: Moderate, High

## Architecture

[architecture diagram to come]

## Dependencies

Internal Modules:
No prerequsite modules are required to deploy this module

AWS Provider 5.0+
IAM permissions to create and manage KMS resources

## Environment Setup

Include the required steps to establish a secure connection to the specific cloud environment used for the build. 
MUST CHANGE PER CLOUD ENVIRONMENT AWS Example:

```hcl
- Download and install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

- Log into the AWS Console and [create AWS CLI Credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

- Configure the named profile used for the project, such as `aws configure --profile example-mgmt`
```

## Tree
```
.
├── CONTRIBUTING.md
├── License.md
├── README.md
├── UpdatedReadMe.md
├── coalfire_logo.png
├── data.tf
├── locals.tf
├── main.tf
├── outputs.tf
├── providers.tf
└── variables.tf
```
## Resource List

AWS KMS Key with customizable policy and automatic key rotation
AWS KMS Alias for easier key identification and management
Automatic AWS partition detection for commercial and GovCloud environments

## Code Updates

The module has been updated with the following improvements:

Automatic AWS partition detection for proper ARN construction when deploying key(s)
Updated tagging to include provider default tags support
Updated examples for common use cases

## Deployment

This section should detail how an engineer with no previous experience with this PAK should go about deploying X resources and any key dependencies or deployment configurations that need to be well documented. 

Example:

1. Create a new directory for your KMS deployment:

    ```hcl
    mkdir -p terraform/kms
    cd terraform/kms
    ```

2. Create a properly defined main.tf file via the template found under 'Usage' while adjusting tfvars as needed. Note that many provided variables are outputs from other modules. See example under 'usage'.

   
3. Initialize the Terraform working directory:
   ```hcl
   terraform init -backend-config=./backends/prefix.tfvars
   ```
   Create an execution plan and verify everything looks correct:
   ```hcl
   terraform plan
   ```
   Apply the configuration:
   ```hcl
   terraform apply -var-file=./tfvars/prefix.tfvars
   ```

## Usage

Include an example for how to call the module below with generic variables. MUST CHANGE PER REPOSITORY example is shown with Azure module:




```hcl

data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}

provider "aws" {
  region = "us-gov-west-1"
  default_tags {
    tags = {
      Application = "This is a test"
      Owner       = "Koda Remenyi"
      Team        = "AWS Native Architecture PAK Team"
      Environment = "dev"
    }
  }
}


data "aws_iam_policy_document" "s3_kms_policy" {
  statement {
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = ["arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
}

module "s3_kms_key" {
  source = "https://github.com/Coalfire-CF/terraform-aws-kms/releases/tag/[latest-version]"

  resource_prefix       = var.resource_prefix
  kms_key_resource_type = "s3"
  key_policy            = data.aws_iam_policy_document.s3_kms_policy.json

  tags = {
      Environment = "govcloud sandbox"
      Owner       = "aws native architecture team"
      Project     = "Pak Party"
  }
}
```


## Post Deployment Configuration

No post deployment configuration is neccessary.

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
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

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
