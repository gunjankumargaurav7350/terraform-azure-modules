run "verify_vnet_creation" {
  command = plan

  variables {
    vnet_name           = "vnet-test"
    resource_group_name = "rg-test"
    location            = "eastus"
    address_space       = ["10.0.0.0/16"]
    subnets = {
      "snet-app" = { address_prefix = "10.0.1.0/24" }
    }
  }

  assert {
    condition     = azurerm_virtual_network.this.name == "vnet-test"
    error_message = "VNet name did not match expected value"
  }
}
