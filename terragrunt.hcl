# Add the following to your root level terragrunt.hcl
locals {
  # Change the location to wherever you store your copy.
  build_providers = run_cmd("--terragrunt-quiet", "curl", "-sL", "https://raw.github.com/grimm26/terragrunt-build-providers/main/build_providers")
}

# Generate all needed providers. If main.tf exists (legacy), this will do nothing.
generate "build_providers" {
  path      = "tgen_providers.tf"
  if_exists = "overwrite"
  contents  = run_cmd("--terragrunt-quiet", "bash", "-c", "eval ${local.build_providers}")
}
