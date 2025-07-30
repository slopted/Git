module "vnet-bkppp-scl-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-bkppp-scl-001"
  location = "chilecentral"
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-bkp-001
  address_space = ["10.134.10.0/24"]
}

# ===========================
#         VERITAS
# ===========================

module "snet-bkppp-bkp-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on = [ module.vnet-bkppp-scl-001 ]
  name     = "snet-bkppp-bkp-001"
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-bkp-001
  virtual_network_name = module.vnet-bkppp-scl-001.name
  address_prefix = ["10.134.10.0/28"]
}