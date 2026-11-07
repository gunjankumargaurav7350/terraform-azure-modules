locals {
  environment = "prod"
  location    = "eastus"
  common_tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    Architect   = "Gunjan Kumar Gaurav"
    Compliance  = "CIS-Azure-Level-2"
  }
}

resource "azurerm_resource_group" "rgs" {
  for_each = toset(["network", "security", "workloads"])

  name     = "rg-${local.environment}-${each.key}"
  location = local.location
  tags     = local.common_tags
}

# 1. Virtual Network Module with for_each subnets
module "vnet" {
  source              = "./modules/vnet"
  vnet_name           = "vnet-${local.environment}-hub"
  resource_group_name = azurerm_resource_group.rgs["network"].name
  location            = local.location
  address_space       = ["10.200.0.0/16"]

  subnets = {
    "snet-ingress" = {
      address_prefix    = "10.200.1.0/24"
      service_endpoints = []
    },
    "snet-security" = {
      address_prefix    = "10.200.2.0/24"
      service_endpoints = ["Microsoft.KeyVault"]
    },
    "snet-compute" = {
      address_prefix    = "10.200.10.0/24"
      service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
    }
  }

  tags = local.common_tags
}

# 2. Network Security Group with for_each rules
module "nsg" {
  source              = "./modules/nsg"
  nsg_name            = "nsg-${local.environment}-hub"
  resource_group_name = azurerm_resource_group.rgs["network"].name
  location            = local.location

  security_rules = {
    "Allow-HTTPS-Inbound" = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      destination_port_range     = "443"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "*"
    },
    "Deny-Internet-Inbound" = {
      priority                   = 4000
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      destination_port_range     = "*"
      source_address_prefix      = "Internet"
      destination_address_prefix = "*"
    }
  }

  tags = local.common_tags
}

# 3. Azure Key Vault with RBAC Authorization
module "keyvault" {
  source                      = "./modules/keyvault"
  key_vault_name              = "kv-${local.environment}-appsec01"
  resource_group_name         = azurerm_resource_group.rgs["security"].name
  location                    = local.location
  sku_name                    = "premium"
  enable_rbac_authorization   = true
  network_acls_default_action = "Deny"
  allowed_subnet_ids          = [module.vnet.subnet_ids["snet-security"]]

  tags = local.common_tags
}
