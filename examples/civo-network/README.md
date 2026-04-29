# Civo Network Example

Provisions a Civo network with firewall using the `civo/network` module.

## Prerequisites

- [OpenTofu](https://opentofu.org/) installed (`tofu` CLI)
- A Civo account and API token
- `CIVO_TOKEN` environment variable set

## Usage

```bash
export CIVO_TOKEN="your-civo-api-token"

tofu init
tofu plan
tofu apply
```

## Clean up

```bash
tofu destroy
```
