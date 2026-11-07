# 📦 Reusable Terraform Azure Enterprise Modules

[![Terraform Version](https://img.shields.io/badge/Terraform-%3E%3D1.5.0-623CE4?style=for-the-badge&logo=terraform)](https://www.terraform.io)
[![Azure Provider](https://img.shields.io/badge/AzureRM-~%3E3.116-0089D6?style=for-the-badge&logo=microsoftazure)](https://registry.terraform.io/providers/hashicorp/azurerm/latest)
[![Design Pattern](https://img.shields.io/badge/Design%20Pattern-for__each%20Modular-success?style=for-the-badge)](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)
[![State Locking](https://img.shields.io/badge/Remote%20State-Azure%20Blob%20Lease-blue?style=for-the-badge)](https://learn.microsoft.com)

Enterprise-grade, modular Terraform library for **Microsoft Azure** written and curated by **Gunjan Kumar Gaurav** (Senior Cloud & DevSecOps Consultant). Designed around strict `for_each` declarative patterns, state locking, and isolated reusable module directories with examples and automated tests.

---

## 🏗️ Module Catalog

| Module | Directory | Key Feature | Pattern Used |
|---|---|---|---|
| **Virtual Network & Subnets** | [`modules/vnet`](./modules/vnet) | Hub-Spoke networks, delegation, endpoints | `for_each = var.subnets` |
| **Network Security Group** | [`modules/nsg`](./modules/nsg) | Dynamic rule definition with prioritization | `for_each = var.security_rules` |
| **Azure Key Vault** | [`modules/keyvault`](./modules/keyvault) | CIS-hardened, RBAC / Access policies, network ACLs | `for_each = var.access_policies` |
| **RBAC Role Assignments** | [`modules/rbac`](./modules/rbac) | Least-privilege role bindings across scopes | `for_each = var.role_assignments` |

---

## 🔒 Remote State & Concurrency Locking

State is secured in a centralized **Azure Blob Storage Container** with automated **Blob Lease state locking**, preventing race conditions during concurrent pipeline runs:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-prod"
    storage_account_name = "sttfstateprod01"
    container_name       = "tfstate"
    key                  = "terraform-azure-modules.tfstate"
    use_azuread_auth     = true
  }
}
```

---

## 📂 Repository Directory Layout

```text
├── backend.tf                  # Remote state configuration with state locking
├── versions.tf                 # Terraform & AzureRM provider pin
├── main.tf                     # Root orchestration deploying all modules via for_each
├── outputs.tf                  # Aggregated outputs
├── modules/
│   ├── vnet/                   # Virtual Network & Subnets module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── examples/complete/
│   │   └── tests/
│   ├── nsg/                    # Network Security Group module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── examples/complete/
│   │   └── tests/
│   ├── keyvault/               # Azure Key Vault module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── examples/complete/
│   │   └── tests/
│   └── rbac/                   # RBAC Role Assignments module
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── examples/complete/
│       └── tests/
└── README.md
```

---

## 🚀 Quickstart Example

```hcl
module "vnet" {
  source              = "git::https://github.com/gunjankumargaurav7350/terraform-azure-modules.git//modules/vnet?ref=v1.0.0"
  vnet_name           = "vnet-prod-hub"
  resource_group_name = "rg-prod-network"
  location            = "eastus"
  address_space       = ["10.0.0.0/16"]

  subnets = {
    "snet-workload" = {
      address_prefix    = "10.0.1.0/24"
      service_endpoints = ["Microsoft.KeyVault"]
    }
  }
}
```

---

## 👤 Author
**Gunjan Kumar Gaurav**  
*Senior Cloud & DevSecOps Consultant*  
[LinkedIn Profile](https://linkedin.com/in/gunjan-gaurav) • [GitHub](https://github.com/gunjankumargaurav7350)
