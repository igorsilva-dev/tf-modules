# Civo Network Example

Provisions a Civo network with firewall using the `civo/network` module.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) or [OpenTofu](https://opentofu.org/) installed
- A Civo account and API token
- `CIVO_TOKEN` environment variable set

## Usage

```bash
export CIVO_TOKEN="your-civo-api-token"

terraform init
terraform plan
terraform apply
```

## Clean up

```bash
terraform destroy
```
