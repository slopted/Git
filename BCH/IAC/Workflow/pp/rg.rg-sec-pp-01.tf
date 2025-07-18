module "rg-sec-pp-01" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group"
  name     = "rg-sec-pp-01"
  location = "chilecentral"
}

module "vnet-secpp-scl-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-secpp-scl-001"
  location = "chilecentral"
  resource_group_name = module.rg-sec-pp-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  address_space = ["10.134.8.0/24"]
}

# ========================================================
#   QRADAR | IMPERVA | DARKTRACE | CYBERARK | BALANCEADOR
# ========================================================

module "snet-secprd-cstools-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-secprd-cstools-001"
  resource_group_name = module.rg-sec-pp-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-secpp-scl-001.name
  address_prefix = ["10.134.8.0/27"]
}

# ===========================
#      BALANCEADOR
# ===========================

module "snet-secprd-lbcstools-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-secprd-lbcstools-001"
  resource_group_name = module.rg-sec-pp-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-secpp-scl-001.name
  address_prefix = ["10.134.8.32/27"]
}

/*
# ===========================
#           ORCA
# ===========================

# WARNING: The following Azure ORCA vnet & subnet configuration is pending review and approval by the project's team.
# Please verify address ranges, naming conventions, and requirements before deployment.

module "vnet-ORCA-scl-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-ORCA-scl-001"
  location = "chilecentral"
  resource_group_name = module.rg-sec-pp-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  address_space = ["TBD"] #UPDATE WITH THE ADDRESS SPACE
}

module "snet-orca-prod-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-ORCA-prod-001"
  resource_group_name = module.rg-sec-pp-01.name
  virtual_network_name = module.vnet-ORCA-scl-001.name
  address_prefix = ["TBD"] #UPDATE WITH THE ADDRESS PREFIX
}
*/