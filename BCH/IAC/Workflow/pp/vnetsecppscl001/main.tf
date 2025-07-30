module "vnet-secpp-scl-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-secpp-scl-001"
  location = "chilecentral"
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-sec-001
  address_space = ["10.134.8.0/24"]
}

# ========================================================
#   QRADAR | IMPERVA | DARKTRACE | CYBERARK | BALANCEADOR
# ========================================================

module "snet-secprd-cstools-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on = [ module.vnet-secpp-scl-001 ]
  name     = "snet-secprd-cstools-001"
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-sec-001
  virtual_network_name = module.vnet-secpp-scl-001.name
  address_prefix = ["10.134.8.0/27"]
}

# ===========================
#      BALANCEADOR
# ===========================

module "snet-secprd-lbcstools-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on = [ module.vnet-secpp-scl-001 ]
  name     = "snet-secprd-lbcstools-001"
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-sec-001
  virtual_network_name = module.vnet-secpp-scl-001.name
  address_prefix = ["10.134.8.32/27"]
}