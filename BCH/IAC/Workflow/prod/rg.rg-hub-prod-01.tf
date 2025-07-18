module "rg-hub-prod-01" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group"
  name     = "rg-hub-prod-01"
  location = "chilecentral"
}

module "vnet-hubprd-scl-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-hubprd-scl-001"
  location = "chilecentral"
  resource_group_name = module.rg-hub-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  address_space = ["10.133.0.0/24","10.133.1.0/24","10.133.2.0/24","10.133.3.0/24","10.133.4.0/24","10.133.5.0/24","10.133.6.0/24","10.133.7.0/24"]
}

# ===========================
#         SDWAN
# ===========================

module "snet-hubprd-sdwan-trust-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubprd-sdwan-trust-001"
  resource_group_name = module.rg-hub-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefix = ["10.133.0.0/28"]
}

module "snet-hubprd-sdwan-untrust-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubprd-sdwan-untrust-001"
  resource_group_name = module.rg-hub-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefix = ["10.133.0.16/28"]
}

module "snet-hubprd-sdwan-ha-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubprd-sdwan-ha-001"
  resource_group_name = module.rg-hub-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefix = ["10.133.0.32/28"]
}

module "snet-hubprd-sdwan-mgmt-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubprd-sdwan-mgmt-001"
  resource_group_name = module.rg-hub-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefix = ["10.133.0.48/28"]
}
# ===========================
#         Bastion
# ===========================

module "AzureBastionSubnet" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "AzureBastionSubnet"
  resource_group_name = module.rg-hub-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefix = ["10.133.1.0/26"]
}

# ===========================
#       DNS Privada
# ===========================

module "snet-hubprd-dns-inbound-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubprd-dns-inbound-001"
  resource_group_name = module.rg-hub-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefix = ["10.133.2.0/28"]
}

module "snet-hubprd-dns-outbound-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubprd-dns-outbound-001"
  resource_group_name = module.rg-hub-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefix = ["10.133.2.16/28"]
}

# ===========================
#   Firewall Palo Alto
# ===========================

# WARNING: The following Palo Alto Firewall subnet configuration is pending review and approval by the project's team.
# Please verify address ranges, naming conventions, and requirements before deployment.

/*
module "snet-hubprd-fwpl-trust-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubprd-fwpl-trust-001"
  resource_group_name = module.rg-hub-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefix = ["10.133.3.0/28"]
}

module "snet-hubprd-fwpl-trust-002" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubprd-fwpl-trust-002"
  resource_group_name = module.rg-hub-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefix = ["10.133.4.0/28"]
}

module "snet-hubprd-fwpl-untrust-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubprd-fwpl-untrust-001"
  resource_group_name = module.rg-hub-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefix = ["10.133.3.16/28"]
}

module "snet-hubprd-fwpl-untrust-002" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubprd-fwpl-untrust-002"
  resource_group_name = module.rg-hub-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefix = ["10.133.4.16/28"]
}

module "snet-hubprd-fwpl-lb-trust-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubprd-fwpl-lb-trust-001"
  resource_group_name = module.rg-hub-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefix = ["10.133.5.0/28"]
}

module "snet-hubprd-fwpl-lb-untrust-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubprd-fwpl-lb-untrust-001"
  resource_group_name = module.rg-hub-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefix = ["10.133.5.16/28"]
}

module "snet-hubprd-fwpl-mgmt-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubprd-fwpl-mgmt-001"
  resource_group_name = module.rg-hub-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefix = ["10.133.3.32/28"]
}
*/

# ===========================
#     Azure Firewall
# =========================

# WARNING: The following Azure Firewall subnet configuration is pending review and approval by the project's team.
# Please verify address ranges, naming conventions, and requirements before deployment.

/*
module "snet-TBD-AzureFirewall-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-TBD-AzureFirewall-001"
  resource_group_name = module.rg-hub-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefix = ["10.133.6.0/26"]
}


module "snet-TBD-AzureFirewall-002" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-TBD-AzureFirewall-002"
  resource_group_name = module.rg-hub-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefix = ["10.133.6.64/26"]
}
*/ 

# ===========================
#      VPN Gateway
# ===========================

# WARNING: The following Azure VPN Gateway subnet configuration is pending review and approval by the project's team.
# Please verify address ranges, naming conventions, and requirements before deployment.
/*
module "snet-TBD-VPNGateway-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-TBD-VPNGateway-001"
  resource_group_name = module.rg-hub-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefix = ["10.133.7.0/26"]
}*/
