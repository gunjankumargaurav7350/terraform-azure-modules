output "hub_vnet_id" {
  description = "Virtual Network resource ID"
  value       = module.vnet.vnet_id
}

output "hub_subnet_ids" {
  description = "Subnet IDs map"
  value       = module.vnet.subnet_ids
}

output "nsg_id" {
  description = "NSG resource ID"
  value       = module.nsg.nsg_id
}

output "key_vault_uri" {
  description = "Key Vault Vault URI"
  value       = module.keyvault.key_vault_uri
}
