module "rg-hub-vdi-prod-01" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group"
  name     = "rg-hub-vdi-prod-01"
  location = "chilecentral"
}

module "vnet-hub-vdi-scl-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-hub-vdi-scl-001"
  location = "chilecentral"
  resource_group_name = module.rg-hub-vdi-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  address_space = ["10.135.0.0/24","10.135.1.0/24","10.135.2.0/24"]
}


# ===========================
#     Azure Firewall
# =========================

# WARNING: The following Azure Firewall subnet configuration is pending review and approval by the project's team.
# Please verify address ranges, naming conventions, and requirements before deployment.
/*
module "snet-hubprd-vdi-fwpl-trust-001" {
  source                = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name                  = "snet-hubprd-vdi-fwpl-trust-001"
  resource_group_name   = module.rg-hub-vdi-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name  = module.vnet-hub-vdi-scl-001.name
  address_prefix        = ["10.133.3.0/28"]
}

module "snet-hubprd-vdi-fwpl-trust-002" {
  source                = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name                  = "snet-hubprd-vdi-fwpl-trust-002"
  resource_group_name   = module.rg-hub-vdi-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name  = module.vnet-hub-vdi-scl-001.name
  address_prefix        = ["10.133.4.0/28"]
}

module "snet-hubprd-vdi-fwpl-untrust-001" {
  source                = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name                  = "snet-hubprd-vdi-fwpl-untrust-001"
  resource_group_name   = module.rg-hub-vdi-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name  = module.vnet-hub-vdi-scl-001.name
  address_prefix        = ["10.133.3.16/28"]
}

module "snet-hubprd-vdi-fwpl-untrust-002" {
  source                = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name                  = "snet-hubprd-vdi-fwpl-untrust-002"
  resource_group_name   = module.rg-hub-vdi-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name  = module.vnet-hub-vdi-scl-001.name
  address_prefix        = ["10.133.4.16/28"]
}

module "snet-hubprd-vdi-fwpl-lb-trust-001" {
  source                = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name                  = "snet-hubprd-vdi-fwpl-lb-trust-001"
  resource_group_name   = module.rg-hub-vdi-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name  = module.vnet-hub-vdi-scl-001.name
  address_prefix        = ["10.133.5.0/28"]
}

module "snet-hubprd-vdi-fwpl-lb-untrust-001" {
  source                = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name                  = "snet-hubprd-vdi-fwpl-lb-untrust-001"
  resource_group_name   = module.rg-hub-vdi-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name  = module.vnet-hub-vdi-scl-001.name
  address_prefix        = ["10.133.5.16/28"]
}

module "snet-hubprd-vdi-fwpl-mgmt-001" {
  source                = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name                  = "snet-hubprd-vdi-fwpl-mgmt-001"
  resource_group_name   = module.rg-hub-vdi-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name  = module.vnet-hub-vdi-scl-001.name
  address_prefix        = ["10.133.3.32/28"]
}*/