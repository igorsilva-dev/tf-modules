# Civo Network Module

Provisions a [Civo](https://www.civo.com/) network with firewall and optional DNS records.

## Usage

### Basic (network + firewall)

```hcl
module "network" {
  source = "git::https://github.com/igorsilva-dev/tf-modules.git//civo/network?ref=v0.1.0"

  network_label        = "my-network"
  firewall_name        = "my-firewall"
  create_default_rules = true
}
```

### With DNS

```hcl
module "network" {
  source = "git::https://github.com/igorsilva-dev/tf-modules.git//civo/network?ref=v0.1.0"

  network_label        = "my-network"
  firewall_name        = "my-firewall"
  create_default_rules = true

  dns_domain = "example.com"
  dns_records = [
    {
      type  = "A"
      name  = "app"
      value = "1.2.3.4"
      ttl   = 600
    },
    {
      type  = "CNAME"
      name  = "www"
      value = "app.example.com"
      ttl   = 3600
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `network_label` | Label for the Civo network | `string` | — | yes |
| `firewall_name` | Name for the Civo firewall | `string` | — | yes |
| `create_default_rules` | Create default firewall rules (SSH, HTTP, HTTPS) | `bool` | `true` | no |
| `dns_domain` | DNS domain to register (leave empty to skip) | `string` | `""` | no |
| `dns_records` | List of DNS records (type, name, value, ttl) | `list(object)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| `network_id` | ID of the created network |
| `network_label` | Label of the created network |
| `firewall_id` | ID of the created firewall |
| `firewall_name` | Name of the created firewall |
| `dns_domain_id` | ID of the DNS domain (empty if not configured) |
| `dns_domain_name` | Name of the DNS domain (empty if not configured) |

## Notes

- The Civo provider must be configured with a valid API token and region in the calling module.
- DNS is entirely optional — when `dns_domain` is empty, no DNS resources are created.
- The `dns_records` variable is only used when `dns_domain` is set.
