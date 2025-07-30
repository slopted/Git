
module "vnet-hub-vdi-scl-001" {
  source              = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name                = "vnet-hub-vdi-scl-001"
  location            = "chilecentral"
  resource_group_name = data.rg-prd-scl-vdi-hub-001.name
  address_space       = ["10.135.0.0/24", "10.135.1.0/24", "10.135.2.0/24"]
}

# ===========================
#   Firewall Palo Alto
# ===========================

module "snet-hubprd-vdi-fwpl-trust-001" {
  source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on           = [module.vnet-hub-vdi-scl-001]
  name                 = "snet-hubprd-vdi-fwpl-trust-001"
  resource_group_name  = data.rg-prd-scl-vdi-hub-001.name
  virtual_network_name = module.vnet-hub-vdi-scl-001.name
  address_prefix       = ["10.135.0.0/28"]
}

module "snet-hubprd-vdi-fwpl-trust-002" {
  source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on           = [module.vnet-hub-vdi-scl-001]
  name                 = "snet-hubprd-vdi-fwpl-trust-002"
  resource_group_name  = data.rg-prd-scl-vdi-hub-001.name
  virtual_network_name = module.vnet-hub-vdi-scl-001.name
  address_prefix       = ["10.135.1.0/28"]
}

module "snet-hubprd-vdi-fwpl-untrust-001" {
  source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on           = [module.vnet-hub-vdi-scl-001]
  name                 = "snet-hubprd-vdi-fwpl-untrust-001"
  resource_group_name  = data.rg-prd-scl-vdi-hub-001.name
  virtual_network_name = module.vnet-hub-vdi-scl-001.name
  address_prefix       = ["10.135.0.16/28"]
}

module "snet-hubprd-vdi-fwpl-untrust-002" {
  source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on           = [module.vnet-hub-vdi-scl-001]
  name                 = "snet-hubprd-vdi-fwpl-untrust-002"
  resource_group_name  = data.rg-prd-scl-vdi-hub-001.name
  virtual_network_name = module.vnet-hub-vdi-scl-001.name
  address_prefix       = ["10.135.1.16/28"]
}

module "snet-hubprd-vdi-fwpl-lb-trust-001" {
  source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on           = [module.vnet-hub-vdi-scl-001]
  name                 = "snet-hubprd-vdi-fwpl-lb-trust-001"
  resource_group_name  = data.rg-prd-scl-vdi-hub-001.name
  virtual_network_name = module.vnet-hub-vdi-scl-001.name
  address_prefix       = ["10.135.2.0/28"]
}

module "snet-hubprd-vdi-fwpl-lb-untrust-001" {
  source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on           = [module.vnet-hub-vdi-scl-001]
  name                 = "snet-hubprd-vdi-fwpl-lb-untrust-001"
  resource_group_name  = data.rg-prd-scl-vdi-hub-001.name
  virtual_network_name = module.vnet-hub-vdi-scl-001.name
  address_prefix       = ["10.135.2.16/28"]
}

module "snet-hubprd-vdi-fwpl-mgmt-001" {
  source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on           = [module.vnet-hub-vdi-scl-001]
  name                 = "snet-hubprd-vdi-fwpl-mgmt-001"
  resource_group_name  = data.rg-prd-scl-vdi-hub-001.name
  virtual_network_name = module.vnet-hub-vdi-scl-001.name
  address_prefix       = ["10.135.0.32/28"]
}