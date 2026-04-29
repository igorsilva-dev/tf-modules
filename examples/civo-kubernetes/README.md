# Civo Kubernetes Example

Provisions a Civo K3s cluster with a dedicated network and firewall using the `civo/kubernetes` and `civo/network` modules.

## Prerequisites

- [OpenTofu](https://opentofu.org/) installed (`tofu` CLI)
- A Civo account and API token
- `CIVO_TOKEN` environment variable set
- Region defaults to `lon1` — override in `providers.tf` if needed

## Usage

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your desired values

export CIVO_TOKEN="your-civo-api-token"

tofu init
tofu plan
tofu apply
```

## Clean up

```bash
tofu destroy
```
