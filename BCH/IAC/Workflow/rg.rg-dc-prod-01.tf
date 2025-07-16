module "rg-dc-prod-01" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group"
  name     = "rg-dc-prod-01"
  location = "chilecentral"
}

module "vnet-dcprd-scl-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-dcprd-scl-001"
  location = "chilecentral"
  resource_group_name = module.rg-dc-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  address_space = ["10.133.9.0/24"]
}

# ===========================
#     DOMAIN CONTROLLER
# ===========================

module "snet-dcprd-addc-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-dcprd-addc-001"
  resource_group_name = module.rg-dc-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-dcprd-scl-001.name
  address_prefix = ["10.133.9.0/26"]
}