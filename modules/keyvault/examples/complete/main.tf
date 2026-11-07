module "keyvault" {
  source                      = "../../"
  key_vault_name              = "kv-prod-app-sec01"
  resource_group_name         = "rg-security-prod"
  location                    = "eastus"
  enable_rbac_authorization   = true
  network_acls_default_action = "Deny"

  tags = {
    Environment = "Prod"
    Security    = "ZeroTrust"
  }
}
