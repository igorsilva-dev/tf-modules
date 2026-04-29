# tf-modules

A library of reusable [OpenTofu](https://opentofu.org/) modules for provisioning Civo cloud infrastructure and Kubernetes platform components. Modules are intentionally small, parameterised, and composable — pull in what you need via a git ref.

This repo is built and tested with **OpenTofu 1.10+**. The Hashicorp Terraform CLI is also compatible, but all examples and tooling assume `tofu`.

## Architecture

```
  ┌──────────────────────────────────────────────────────────────┐
  │                        tf-modules                            │
  │                                                              │
  │  ┌──────────────┐   ┌──────────────┐   ┌────────────────┐    │
  │  │ civo/network │──▶│civo/kubernetes│   │     helm       │    │
  │  │              │   │               │   │ (provider-     │    │
  │  │ network +    │   │ K3s cluster + │   │  agnostic)     │    │
  │  │ firewall +   │   │ kubeconfig    │   │                │    │
  │  │ DNS          │   │               │   │                │    │
  │  └──────────────┘   └──────┬────────┘   └────────────────┘    │
  │                            │                                  │
  │                            ▼                                  │
  │                  ┌─────────────────────┐                      │
  │                  │ kubernetes/         │                      │
  │                  │   namespaces-rbac   │                      │
  │                  │ namespaces + SAs +  │                      │
  │                  │ read-only RBAC      │                      │
  │                  └─────────────────────┘                      │
  └──────────────────────────────────────────────────────────────┘
                              │
                              │ consumed via git ref
                              ▼
                  ┌─────────────────────────┐
                  │  civo-infrastructure    │
                  │  (Terragrunt + OpenTofu)│
                  │  state: Civo Object     │
                  │  Store (S3-compatible)  │
                  └─────────────────────────┘
```

## Module index

| Module | Path | Purpose | Docs |
|--------|------|---------|------|
| Civo network | [`civo/network`](civo/network/) | Network + firewall, optional DNS domain and records | [README](civo/network/README.md) |
| Civo Kubernetes | [`civo/kubernetes`](civo/kubernetes/) | K3s-based Civo cluster with configurable node pools | [README](civo/kubernetes/README.md) |
| Helm release | [`helm`](helm/) | Generic `helm_release` wrapper with `set` / `set_sensitive` support | [README](helm/README.md) |
| Kubernetes namespaces & RBAC | [`kubernetes/namespaces-rbac`](kubernetes/namespaces-rbac/) | Namespaces + service accounts + read-only ClusterRole | [README](kubernetes/namespaces-rbac/README.md) |

> The `aws/*` directory contains experimental scaffolding and is not part of the v0.1.0 surface.

Working examples for each module live under [`examples/`](examples/).

## Quick start

Run any example with OpenTofu:

```bash
cd examples/civo-kubernetes
tofu init
tofu plan
tofu apply
```

To consume a module from another repo, pin to a tag:

```hcl
module "network" {
  source = "git::https://github.com/igorsilva-dev/tf-modules.git//civo/network?ref=v2026.04.27.04"

  network_label        = "main"
  firewall_name        = "main"
  create_default_rules = true
}

module "kubernetes" {
  source = "git::https://github.com/igorsilva-dev/tf-modules.git//civo/kubernetes?ref=v2026.04.27.04"

  cluster_name       = "platform"
  kubernetes_version = "1.34.2-k3s1"
  network_id         = module.network.network_id
  firewall_id        = module.network.firewall_id

  pools = [
    { label = "workers", size = "g4s.kube.xsmall", node_count = 2 },
  ]
}
```

Always pin `?ref=<tag>` — never use a branch ref in shared infrastructure.

## Versioning

Tags use a rolling date-based scheme — `vYYYY.MM.DD.NN` — for every published change. Semantic milestones (`v0.1.0`, `v1.0.0`, …) are layered on top to mark portfolio milestones.

| Tag pattern | Meaning |
|-------------|---------|
| `vYYYY.MM.DD.NN` | Rolling release, every merge to `main` |
| `v0.1.0` | First milestone — all Phase 0 modules functional |
| `v1.0.0` | Portfolio-ready, polished, documented |

See [release tags](https://github.com/igorsilva-dev/tf-modules/tags) for the latest.

## Remote state

These modules are stateless on their own — state lives with the consumer. The reference consumer ([`civo-infrastructure`](https://github.com/igorsilva-dev/civo-infrastructure)) uses the **Civo Object Store** as an S3-compatible backend, configured once at the Terragrunt root.

Minimal OpenTofu backend configuration:

```hcl
terraform {
  backend "s3" {
    endpoint                    = "https://objectstore.lon1.civo.com"
    bucket                      = "tf-backend"
    key                         = "<env>/<stack>/tofu.tfstate"
    region                      = "LON1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}
```

The `access_key` / `secret_key` come from a Civo Object Store credential, exported as env vars (`CIVO_ACCESS_KEY`, `CIVO_SECRET_KEY` in the consumer repo, mapped at runtime).

For Terragrunt-driven setups, generate the backend block in a root `terragrunt.hcl` so every stack inherits it — see `civo-infrastructure/root.hcl` for a working pattern.

## Tooling

The repo expects:

| Tool | Version | Purpose |
|------|---------|---------|
| OpenTofu | `>= 1.10` | `tofu` CLI |
| pre-commit | `>= 3.6` | Local hook runner |
| TFLint | `>= 0.53` | Lint pass |
| tfsec | latest | Security scan (CI only) |

Install via [asdf](https://asdf-vm.com/) using `.tool-versions` if present.

### Local checks

```bash
tofu fmt -check -recursive
tofu -chdir=civo/kubernetes init -backend=false
tofu -chdir=civo/kubernetes validate
pre-commit run --all-files
```

## CI

Every PR runs four GitHub Actions jobs in `.github/workflows/validate.yaml`:

| Job | What it does |
|-----|--------------|
| **Format Check** | `tofu fmt -check -recursive -diff` |
| **Validate Modules** | Matrix `tofu init -backend=false && tofu validate` per module |
| **Lint** | `tflint` per module with the recommended preset |
| **Security Scan** | `tfsec` at `--minimum-severity MEDIUM` |

A red CI blocks merge.

## Repository layout

```
tf-modules/
├── civo/
│   ├── kubernetes/        # K3s cluster module
│   └── network/           # Network + firewall + DNS module
├── helm/                  # Generic Helm release wrapper
├── kubernetes/
│   └── namespaces-rbac/   # Namespaces + service accounts + RBAC
├── aws/                   # Experimental — not part of v0.1.0
├── examples/              # Runnable example per module
│   ├── civo-kubernetes/
│   ├── civo-network/
│   ├── helm-release/
│   └── kubernetes-namespaces-rbac/
├── .github/workflows/     # CI pipelines
├── .pre-commit-config.yaml
├── .tflint.hcl
└── README.md
```

## Contributing

1. Branch from `main` using a `feat/`, `fix/`, or `chore/` prefix.
2. Run `pre-commit run --all-files` and `tofu fmt -recursive` before pushing.
3. Open a PR — CI must pass.
4. Conventional Commits (`feat:`, `fix:`, `chore:`, `docs:`) keep the history readable and feed future changelog automation.

## License

Released under the MIT License. See [LICENSE](LICENSE) if present, otherwise treat as MIT pending a `LICENSE` file.
