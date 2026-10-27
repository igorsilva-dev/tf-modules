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

### Locked-down firewall

Civo's default rules (`create_default_rules = true`) allow **all** inbound TCP/UDP/ICMP from `0.0.0.0/0`. Passing `ingress_rules` replaces them: only the listed ports are open from outside, all traffic from the network's own CIDR stays allowed (node to node; turn off with `allow_internal_traffic = false`), and all outbound traffic is allowed unless `egress_rules` says otherwise.

```hcl
module "network" {
  source = "git::https://github.com/igorsilva-dev/tf-modules.git//civo/network?ref=<tag>"

  network_label = "my-network"
  firewall_name = "my-firewall"

  ingress_rules = [
    { label = "kubernetes-api", port_range = "6443", cidr = ["0.0.0.0/0"] },
  ]
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
| `create_default_rules` | Create Civo's default rules: **all** TCP/UDP/ICMP open from `0.0.0.0/0`. Forced to `false` when custom rules are set | `bool` | `true` | no |
| `ingress_rules` | Inbound allow rules (`label`, `protocol` = tcp, `port_range`, `cidr`). Replaces the defaults | `list(object)` | `null` | no |
| `egress_rules` | Outbound allow rules. With custom rules and `null`, all outbound is allowed | `list(object)` | `null` | no |
| `allow_internal_traffic` | With custom rules, allow everything from the network's own CIDR | `bool` | `true` | no |
| `dns_domain` | DNS domain to register (leave empty to skip) | `string` | `""` | no |
| `dns_records` | List of DNS records (type, name, value, ttl) | `list(object)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| `network_cidr` | IPv4 CIDR of the network |
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
