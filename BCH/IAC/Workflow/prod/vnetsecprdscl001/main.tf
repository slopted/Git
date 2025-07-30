module "vnet-secprd-scl-001" {
  source              = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name                = "vnet-secprd-scl-001"
  location            = "chilecentral"
  resource_group_name = data.rg-prd-scl-sec-001.name
  address_space       = ["10.133.8.0/24"]
}

# ========================================================
#   QRADAR | IMPERVA | DARKTRACE | CYBERARK | BALANCEADOR
# ========================================================

module "snet-secprd-cstools-001" {
  source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on           = [module.vnet-secprd-scl-001]
  name                 = "snet-secprd-cstools-001"
  resource_group_name  = data.rg-prd-scl-sec-001.name
  virtual_network_name = module.vnet-secprd-scl-001.name
  address_prefix       = ["10.133.8.0/27"]
}

# ===========================
#      BALANCEADOR
# ===========================

module "snet-secprd-lbcstools-001" {
  source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on           = [module.vnet-secprd-scl-001]
  name                 = "snet-secprd-lbcstools-001"
  resource_group_name  = data.rg-prd-scl-sec-001.name
  virtual_network_name = module.vnet-secprd-scl-001.name
  address_prefix       = ["10.133.8.32/27"]
}