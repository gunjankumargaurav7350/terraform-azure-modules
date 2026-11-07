module "web_nsg" {
  source              = "../../"
  nsg_name            = "nsg-prod-web"
  resource_group_name = "rg-network-prod"
  location            = "eastus"

  security_rules = {
    "Allow-HTTPS" = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      destination_port_range     = "443"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "*"
    },
    "Deny-All-Inbound" = {
      priority                   = 4096
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}
