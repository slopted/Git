module "rg-dc-pp-01" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group"
  name     = "rg-dc-pp-01"
  location = "chilecentral"
}

module "vnet-dcpp-scl-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-dcpp-scl-001"
  location = "chilecentral"
  resource_group_name = module.rg-dc-pp-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  address_space = ["10.134.9.0/24"]
}

# ===========================
#     DOMAIN CONTROLLER
# ===========================

module "snet-dcpp-addc-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-dcpp-addc-001"
  resource_group_name = module.rg-dc-pp-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-dcpp-scl-001.name
  address_prefix = ["10.134.9.0/26"]
}