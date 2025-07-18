module "rg-ele-01" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group"
  name     = "rg-ele-01"
  location = "chilecentral"
}

module "vnet-ele" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-ele"
  location = "chilecentral"
  resource_group_name = module.rg-ele-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  address_space = ["10.134.66.0/24"]
}

# ===========================
# ELE
# ===========================

module "snet-TBD-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-TBD-001"
  resource_group_name = module.rg-ele-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-ele.name
  address_prefix = ["10.134.66.0/29"]
}

module "snet-TBD-002" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-TBD-002"
  resource_group_name = module.rg-ele-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-ele.name
  address_prefix = ["10.134.66.8/29"]
}
