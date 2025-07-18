module "rg-bkp-pp-01" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group"
  name     = "rg-bkp-pp-01"
  location = "chilecentral"
}

module "vnet-bkppp-scl-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-bkppp-scl-001"
  location = "chilecentral"
  resource_group_name = module.rg-bkp-pp-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  address_space = ["10.134.10.0/24"]
}

# ===========================
#         VERITAS
# ===========================

module "snet-bkpprd-bkp-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-bkpprd-bkp-001"
  resource_group_name = module.rg-bkp-pp-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-bkppp-scl-001.name
  address_prefix = ["10.134.10.0/28"]
}