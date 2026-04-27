module "namespaces" {
  source = "../../kubernetes/namespaces-rbac"

  namespaces = [
    {
      name   = "platform"
      labels = { "team" = "platform", "tier" = "infra" }
    },
    {
      name   = "agents"
      labels = { "team" = "ai", "tier" = "workloads" }
    },
    {
      name   = "sandbox"
      labels = { "team" = "dev", "tier" = "experiments" }
    }
  ]

  create_service_accounts = var.create_service_accounts
  create_read_only_role   = var.create_read_only_role
}
