# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html) for milestone releases. Day-to-day rolling releases use a `vYYYY.MM.DD.NN` date-based scheme generated automatically on every merge to `main`.

## [0.1.0] — 2026-04-29

First milestone release. All Phase 0 modules from the Portfolio Roadmap are functional, documented, and covered by CI.

### Added
- **Module**: `civo/network` — provisions a Civo network and firewall, with optional DNS domain and records (gated by `dns_domain`).
- **Module**: `civo/kubernetes` — provisions a K3s-based Civo cluster with configurable node pools, optional kubeconfig write to disk.
- **Module**: `helm` — generic `helm_release` wrapper supporting `dynamic "set"` and `dynamic "set_sensitive"` blocks.
- **Module**: `kubernetes/namespaces-rbac` — creates namespaces from a configurable list, optional service accounts, and a read-only ClusterRole with per-namespace bindings for platform observability.
- **Examples**: runnable example for each module under `examples/` — `civo-kubernetes`, `civo-network`, `helm-release`, `kubernetes-namespaces-rbac`.
- **CI pipeline** (`.github/workflows/validate.yaml`): format check, per-module validate matrix, TFLint, tfsec.
- **Pre-commit config** (`.pre-commit-config.yaml`): `terraform_fmt`, `terraform_validate`, `terraform_tflint`, plus standard hygiene hooks (trailing whitespace, EOF fixer, merge-conflict check).
- **TFLint config** (`.tflint.hcl`): `terraform` recommended preset, `terraform_required_version` rule disabled to keep modules consumer-agnostic.
- **Root README**: architecture diagram, module index, quick start, versioning strategy, Civo Object Store remote state pattern, tooling, CI overview, repository layout.
- Per-module READMEs with inputs/outputs tables for every module.

### Changed
- `helm` module: `set_values` is now wired through a `dynamic "set"` block (previously concatenated into `values`, which produced invalid YAML).
- All examples and documentation reference OpenTofu (`tofu`) consistently — Terraform CLI remains compatible but is no longer documented as the primary path.
- `civo-kubernetes` example default `kubernetes_version` bumped from the deprecated `1.32.5-k3s1` to the current stable `1.34.2-k3s1`.

### Fixed
- `helm` module `set_values`: previously broken concat into `values` replaced with a proper `dynamic "set"` block.
- `helm` module `set_sensitive_values`: variable was originally documented in the README but never wired in code. Now implemented via `dynamic "set_sensitive"`.
- `kubernetes/namespaces-rbac`: uses `_v1` resource variants (`kubernetes_namespace_v1`, `kubernetes_service_account_v1`, etc.) to avoid provider deprecation warnings.

### Notes
- `aws/*` modules in the repository are experimental scaffolding and are not part of the v0.1.0 surface.
- The reference consumer of these modules is [`civo-infrastructure`](https://github.com/igorsilva-dev/civo-infrastructure), which uses Terragrunt with a Civo Object Store S3-compatible backend for state.

[0.1.0]: https://github.com/igorsilva-dev/tf-modules/releases/tag/v0.1.0
