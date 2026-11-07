module "rbac" {
  source = "../../"

  role_assignments = {
    "sp-devops-contributor" = {
      scope                = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-app-prod"
      role_definition_name = "Contributor"
      principal_id         = "11111111-1111-1111-1111-111111111111"
      description          = "DevOps Pipeline Service Principal least privilege scope"
    },
    "sec-team-keyvault-reader" = {
      scope                = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-security-prod"
      role_definition_name = "Key Vault Secrets User"
      principal_id         = "22222222-2222-2222-2222-222222222222"
      description          = "Security team Key Vault secret access"
    }
  }
}
