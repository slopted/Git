module "vnet-ele" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-ele"
  location = "chilecentral"
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-ele-001
  address_space = ["10.134.66.0/24"]
}

# ===========================
# ELE
# ===========================

module "snet-ele-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on = [ module.vnet-ele ]
  name     = "snet-ele-001"
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-ele-001
  virtual_network_name = module.vnet-ele.name
  address_prefix = ["10.134.66.0/29"]
}

module "snet-ele-002" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on = [ module.vnet-ele ]
  name     = "snet-ele-002"
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-ele-001
  virtual_network_name = module.vnet-ele.name
  address_prefix = ["10.134.66.8/29"]
}