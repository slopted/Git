module "rg-hubpp-scl-01" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group"
  name     = "rg-hubpp-scl-01"
  location = "chilecentral"
}

module "vnet-hubpp-scl-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-hubpp-scl-001"
  location = "chilecentral"
  resource_group_name = module.rg-hubpp-scl-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  address_space = ["10.134.0.0/24","10.134.1.0/24","10.134.2.0/24","10.134.3.0/24","10.134.4.0/24","10.134.5.0/24","10.134.6.0/24","10.134.7.0/24"]
}


# ===========================
#         SDWAN
# ===========================

module "snet-hubpp-sdwan-trust-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubpp-sdwan-trust-001"
  resource_group_name = module.rg-hubpp-scl-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubpp-scl-001.name
  address_prefix = ["10.134.0.0/28"]
}

module "snet-hubpp-sdwan-untrust-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubpp-sdwan-untrust-001"
  resource_group_name = module.rg-hubpp-scl-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubpp-scl-001.name
  address_prefix = ["10.134.0.16/28"]
}

module "snet-hubpp-sdwan-ha-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubpp-sdwan-ha-001"
  resource_group_name = module.rg-hubpp-scl-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubpp-scl-001.name
  address_prefix = ["10.134.0.32/28"]
}

module "snet-hubpp-sdwan-mgmt-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubpp-sdwan-mgmt-001"
  resource_group_name = module.rg-hubpp-scl-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubpp-scl-001.name
  address_prefix = ["10.134.0.48/28"]
}
# ===========================
#         Bastion
# ===========================

module "AzureBastionSubnet" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "AzureBastionSubnet"
  resource_group_name = module.rg-hubpp-scl-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubpp-scl-001.name
  address_prefix = ["10.134.1.0/26"]
}

# ===========================
#       DNS Privada
# ===========================

module "snet-hubpp-dns-inbound-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubpp-dns-inbound-001"
  resource_group_name = module.rg-hubpp-scl-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubpp-scl-001.name
  address_prefix = ["10.134.2.0/28"]
}

module "snet-hubpp-dns-outbound-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubpp-dns-outbound-001"
  resource_group_name = module.rg-hubpp-scl-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubpp-scl-001.name
  address_prefix = ["10.134.2.16/28"]
}

# ===========================
#   Firewall Palo Alto
# ===========================

# WARNING: The following Palo Alto Firewall subnet configuration is pending review and approval by the project's team.
# Please verify address ranges, naming conventions, and requirements before deployment.

/*
module "snet-hubpp-fwpl-trust-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubpp-fwpl-trust-001"
  resource_group_name = module.rg-hubpp-scl-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubpp-scl-001.name
  address_prefix = ["10.134.3.0/28"]
}

module "snet-hubpp-fwpl-trust-002" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubpp-fwpl-trust-002"
  resource_group_name = module.rg-hubpp-scl-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubpp-scl-001.name
  address_prefix = ["10.134.4.0/28"]
}

module "snet-hubpp-fwpl-untrust-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubpp-fwpl-untrust-001"
  resource_group_name = module.rg-hubpp-scl-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubpp-scl-001.name
  address_prefix = ["10.134.3.16/28"]
}

module "snet-hubpp-fwpl-untrust-002" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubpp-fwpl-untrust-002"
  resource_group_name = module.rg-hubpp-scl-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubpp-scl-001.name
  address_prefix = ["10.134.4.16/28"]
}

module "snet-hubpp-fwpl-lb-trust-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubpp-fwpl-lb-trust-001"
  resource_group_name = module.rg-hubpp-scl-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubpp-scl-001.name
  address_prefix = ["10.134.5.0/28"]
}

module "snet-hubpp-fwpl-lb-untrust-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubpp-fwpl-lb-untrust-001"
  resource_group_name = module.rg-hubpp-scl-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubpp-scl-001.name
  address_prefix = ["10.134.5.16/28"]
}

module "snet-hubpp-fwpl-mgmt-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-hubpp-fwpl-mgmt-001"
  resource_group_name = module.rg-hubpp-scl-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubpp-scl-001.name
  address_prefix = ["10.134.3.32/28"]
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
  resource_group_name = module.rg-hubpp-scl-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubpp-scl-001.name
  address_prefix = ["10.134.6.0/26"]
}


module "snet-TBD-AzureFirewall-002" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-TBD-AzureFirewall-002"
  resource_group_name = module.rg-hubpp-scl-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubpp-scl-001.name
  address_prefix = ["10.134.6.64/26"]
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
  resource_group_name = module.rg-hubpp-scl-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-hubpp-scl-001.name
  address_prefix = ["10.134.7.0/26"]
}*/
