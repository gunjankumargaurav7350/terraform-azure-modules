module "vnet" {
  source              = "../../"
  vnet_name           = "vnet-prod-hub-01"
  resource_group_name = "rg-network-prod"
  location            = "eastus"
  address_space       = ["10.100.0.0/16"]

  subnets = {
    "snet-gateway" = {
      address_prefix    = "10.100.1.0/24"
      service_endpoints = []
    },
    "snet-firewall" = {
      address_prefix    = "10.100.2.0/24"
      service_endpoints = []
    },
    "snet-workload" = {
      address_prefix    = "10.100.3.0/24"
      service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]
    }
  }

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}
