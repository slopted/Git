module "vnet-sharedpp-scl-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-sharedpp-scl-001"
  location = "chilecentral"
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-shared-001
  address_space = ["10.134.11.0/24"]
}


# ===========================
#   ZABBIX | MONITOREO
# ===========================

module "snet-sharedpp-serv-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on = [ module.vnet-sharedpp-scl-001 ]
  name     = "snet-sharedpp-serv-001"
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-shared-001
  virtual_network_name = module.vnet-sharedpp-scl-001.name
  address_prefix = ["10.134.11.0/26"]
}

# ===========================
# BALANCEADOR DE CARGA
# ===========================

module "snet-sharedpp-lbserv-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on = [ module.vnet-sharedpp-scl-001 ]
  name     = "snet-sharedpp-lbserv-001"
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-shared-001
  virtual_network_name = module.vnet-sharedpp-scl-001.name
  address_prefix = ["10.134.11.64/27"]
}