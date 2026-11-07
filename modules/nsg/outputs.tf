output "nsg_id" { value = azurerm_network_security_group.this.id }
output "nsg_name" { value = azurerm_network_security_group.this.name }
output "rule_names" {
  value = [for r in azurerm_network_security_rule.rules : r.name]
}
