resource "azurerm_role_assignment" "assignments" {
  for_each = var.role_assignments

  scope                = each.value.scope
  role_definition_name = lookup(each.value, "role_definition_name", null)
  role_definition_id   = lookup(each.value, "role_definition_id", null)
  principal_id         = each.value.principal_id
  description          = lookup(each.value, "description", null)
}
