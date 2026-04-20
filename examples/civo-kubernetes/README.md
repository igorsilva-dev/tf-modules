# Civo Kubernetes Example

Provisions a Civo K3s cluster with a dedicated network and firewall using the `civo/kubernetes` and `civo/network` modules.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) or [OpenTofu](https://opentofu.org/) installed
- A Civo account and API token
- `CIVO_TOKEN` environment variable set

## Usage

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your desired values

export CIVO_TOKEN="your-civo-api-token"

terraform init
terraform plan
terraform apply
```

## Clean up

```bash
terraform destroy
```
