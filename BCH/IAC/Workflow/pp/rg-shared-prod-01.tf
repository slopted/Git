module "rg-shared-pp-01" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group"
  name     = "rg-sharedpp-pp-01"
  location = "chilecentral"
}

module "vnet-sharedpp-scl-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-sharedpp-scl-001"
  location = "chilecentral"
  resource_group_name = module.rg-shared-pp-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  address_space = ["10.134.11.0/24"]
}


# ===========================
#   ZABBIX | MONITOREO
# ===========================

module "snet-sharedpp-serv-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-sharedpp-serv-001"
  resource_group_name = module.rg-shared-pp-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-sharedpp-scl-001.name
  address_prefix = ["10.134.11.0/26"]
}

# ===========================
# BALANCEADOR DE CARGA
# ===========================

module "snet-sharedpp-lbserv-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-sharedpp-lbserv-001"
  resource_group_name = module.rg-shared-pp-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-sharedpp-scl-001.name
  address_prefix = ["10.134.11.64/27"]
}