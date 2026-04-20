plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

# Modules should not constrain the Terraform/OpenTofu version — that is the consumer's responsibility
rule "terraform_required_version" {
  enabled = false
}
