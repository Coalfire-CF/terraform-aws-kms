<div align="center">
<img src="coalfire_logo.png" width="200">

</div>

# Coalfire pak README Template

## Repository Title

Include the name of the Repository as the header above e.g. `ACE-Cloud-Service`

## Dependencies

List any dependencies here. E.g. security-core, region-setup

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
  create_s3_key = true
  create_ecr_key = true
  create_ebs_key = true
  create_kms_key = true
  create_sm_key = true
  create_k8s_key = false
  create_lambda_key true 
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
| [aws_kms_alias.backup_key_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_alias.dynamo_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_alias.ebs_key_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_alias.lambda_key_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_alias.rds_key_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_alias.s3_key_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_alias.secrets_manager_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_alias.sqs_key_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.backup_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.dynamo_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.ebs_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.k8s_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.lambda_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.rds_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.s3_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.secrets_manager_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.sqs_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_number"></a> [account\_number](#input\_account\_number) | n/a | `any` | n/a | yes |
| <a name="input_application_account_numbers"></a> [application\_account\_numbers](#input\_application\_account\_numbers) | n/a | `any` | n/a | yes |
| <a name="input_backup_key_policy"></a> [backup\_key\_policy](#input\_backup\_key\_policy) | IAM key policy for backup key | `any` | n/a | yes |
| <a name="input_create_backup_key"></a> [create\_backup\_key](#input\_create\_backup\_key) | flag to create backup kms key | `any` | n/a | yes |
| <a name="input_create_dynamo_key"></a> [create\_dynamo\_key](#input\_create\_dynamo\_key) | flag to create dynamic kms key | `any` | n/a | yes |
| <a name="input_create_ebs_key"></a> [create\_ebs\_key](#input\_create\_ebs\_key) | flag to create ebs kms key | `any` | n/a | yes |
| <a name="input_create_ecr_key"></a> [create\_ecr\_key](#input\_create\_ecr\_key) | flag to create ecr kms key | `any` | n/a | yes |
| <a name="input_create_ecs_key"></a> [create\_ecs\_key](#input\_create\_ecs\_key) | flag to create ecs kms key | `any` | n/a | yes |
| <a name="input_create_k8s_key"></a> [create\_k8s\_key](#input\_create\_k8s\_key) | flag to create k8s kms key | `any` | n/a | yes |
| <a name="input_create_lambda_key"></a> [create\_lambda\_key](#input\_create\_lambda\_key) | flag to create lambda kms key | `any` | n/a | yes |
| <a name="input_create_rds_key"></a> [create\_rds\_key](#input\_create\_rds\_key) | flag to create rds kms key | `any` | n/a | yes |
| <a name="input_create_s3_key"></a> [create\_s3\_key](#input\_create\_s3\_key) | flag to create s3 kms key | `any` | n/a | yes |
| <a name="input_create_sm_key"></a> [create\_sm\_key](#input\_create\_sm\_key) | flag to create sm kms key | `any` | n/a | yes |
| <a name="input_create_sqs_key"></a> [create\_sqs\_key](#input\_create\_sqs\_key) | flag to create sqs kms key | `any` | n/a | yes |
| <a name="input_default_aws_region"></a> [default\_aws\_region](#input\_default\_aws\_region) | n/a | `any` | n/a | yes |
| <a name="input_dynamo_key_policy"></a> [dynamo\_key\_policy](#input\_dynamo\_key\_policy) | IAM key policy for dynamo key | `any` | n/a | yes |
| <a name="input_ebs_key_policy"></a> [ebs\_key\_policy](#input\_ebs\_key\_policy) | IAM key policy for EBS key | `any` | n/a | yes |
| <a name="input_ecr_key_policy"></a> [ecr\_key\_policy](#input\_ecr\_key\_policy) | IAM key policy for ecr key | `any` | n/a | yes |
| <a name="input_ecs_key_policy"></a> [ecs\_key\_policy](#input\_ecs\_key\_policy) | IAM key policy for ecs key | `any` | n/a | yes |
| <a name="input_k8s_key_policy"></a> [k8s\_key\_policy](#input\_k8s\_key\_policy) | IAM key policy for K8S key | `any` | n/a | yes |
| <a name="input_lambda_key_policy"></a> [lambda\_key\_policy](#input\_lambda\_key\_policy) | IAM key policy for lambda key | `any` | n/a | yes |
| <a name="input_partition"></a> [partition](#input\_partition) | n/a | `any` | n/a | yes |
| <a name="input_rds_key_policy"></a> [rds\_key\_policy](#input\_rds\_key\_policy) | IAM key policy for rds key | `any` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | n/a | `any` | n/a | yes |
| <a name="input_s3_key_policy"></a> [s3\_key\_policy](#input\_s3\_key\_policy) | IAM key policy for S3 key | `any` | n/a | yes |
| <a name="input_sm_key_policy"></a> [sm\_key\_policy](#input\_sm\_key\_policy) | IAM key policy for secrets manager key | `any` | n/a | yes |
| <a name="input_sqs_key_policy"></a> [sqs\_key\_policy](#input\_sqs\_key\_policy) | IAM key policy for sqs key | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backup_key_arn"></a> [backup\_key\_arn](#output\_backup\_key\_arn) | The arn of the AWS Backup kms key |
| <a name="output_backup_key_id"></a> [backup\_key\_id](#output\_backup\_key\_id) | The id of the AWS Backup key |
| <a name="output_dynamo_key_arn"></a> [dynamo\_key\_arn](#output\_dynamo\_key\_arn) | The arn of the dynamodb kms key |
| <a name="output_dynamo_key_id"></a> [dynamo\_key\_id](#output\_dynamo\_key\_id) | The id of the dynamodb key |
| <a name="output_ebs_key_arn"></a> [ebs\_key\_arn](#output\_ebs\_key\_arn) | The arn of the ebs kms key |
| <a name="output_ebs_key_id"></a> [ebs\_key\_id](#output\_ebs\_key\_id) | The id of the ebs key |
| <a name="output_k8s_key_arn"></a> [k8s\_key\_arn](#output\_k8s\_key\_arn) | The arn of the k8s key |
| <a name="output_k8s_key_id"></a> [k8s\_key\_id](#output\_k8s\_key\_id) | The id of the k8s key |
| <a name="output_lambda_key_arn"></a> [lambda\_key\_arn](#output\_lambda\_key\_arn) | The arn of the lambda kms key |
| <a name="output_lambda_key_id"></a> [lambda\_key\_id](#output\_lambda\_key\_id) | The id of the lambda key |
| <a name="output_rds_key_arn"></a> [rds\_key\_arn](#output\_rds\_key\_arn) | The arn of the rds kms key |
| <a name="output_rds_key_id"></a> [rds\_key\_id](#output\_rds\_key\_id) | The id of the rds key |
| <a name="output_s3_key_arn"></a> [s3\_key\_arn](#output\_s3\_key\_arn) | The arn of the s3 kms key |
| <a name="output_s3_key_id"></a> [s3\_key\_id](#output\_s3\_key\_id) | The id of the s3 key |
| <a name="output_secrets_manager_key_arn"></a> [secrets\_manager\_key\_arn](#output\_secrets\_manager\_key\_arn) | The arn of the secrets manager kms key |
| <a name="output_secrets_manager_key_id"></a> [secrets\_manager\_key\_id](#output\_secrets\_manager\_key\_id) | The id of the secrets manager key |
| <a name="output_sqs_key_arn"></a> [sqs\_key\_arn](#output\_sqs\_key\_arn) | The arn of the sqs kms key |
| <a name="output_sqs_key_id"></a> [sqs\_key\_id](#output\_sqs\_key\_id) | The id of the sqs key |
<!-- END_TF_DOCS -->

## Contributing

[Relative or absolute link to contributing.md](CONTRIBUTING.md)


## License

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/license/mit/)


## Coalfire Pages

[Absolute link to any relevant Coalfire Pages](https://coalfire.com/)

### Copyright

Copyright © 2023 Coalfire Systems Inc.
