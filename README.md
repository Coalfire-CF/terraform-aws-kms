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

ALLOW TERRAFORM MARKDOWN GITHUB ACTION TO POPULATE THE BELOW

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|

## Modules

| Name | Source | Version |
|------|--------|---------|

## Resources

| Name | Type |
|------|------|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|

## Outputs

| Name | Description |
|------|-------------|

<!-- END_TF_DOCS -->

## Contributing

[Relative or absolute link to contributing.md](CONTRIBUTING.md)


## License

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/license/mit/)


## Coalfire Pages

[Absolute link to any relevant Coalfire Pages](https://coalfire.com/)

### Copyright

Copyright © 2023 Coalfire Systems Inc.
