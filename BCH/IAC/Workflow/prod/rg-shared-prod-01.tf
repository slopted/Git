module "rg-shared-prod-01" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group"
  name     = "rg-sharedprd-prod-01"
  location = "chilecentral"
}

module "vnet-sharedprd-scl-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-sharedprd-scl-001"
  location = "chilecentral"
  resource_group_name = module.rg-shared-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  address_space = ["10.133.11.0/24"]
}


# ===========================
#   ZABBIX | MONITOREO
# ===========================

module "snet-sharedprd-serv-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-sharedprd-serv-001"
  resource_group_name = module.rg-shared-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-sharedprd-scl-001.name
  address_prefix = ["10.133.11.0/26"]
}

# ===========================
# BALANCEADOR DE CARGA
# ===========================

module "snet-sharedprd-lbserv-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-sharedprd-lbserv-001"
  resource_group_name = module.rg-shared-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-sharedprd-scl-001.name
  address_prefix = ["10.133.11.64/27"]
}