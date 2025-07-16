module "rg-vdi-int-scl-001-prod-01" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group"
  name     = "rg-vdi-int-scl-001-prod-01"
  location = "chilecentral"
}

module "vnet-vdi-int-scl-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-vdi-int-scl-001"
  location = "chilecentral"
  resource_group_name = module.rg-vdi-int-scl-001-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  address_space = ["10.135.160.0/19","10.135.192.0/19","10.135.224.0/19"]
}

# ==========================================================
#  ESCRITORIOS AVD INTERNOS (4500 USUARIOS)
# ==========================================================

# WARNING: The following Azure ESCRITORIOS AVD INTERNOS (4500 USUARIOS) subnet configuration is pending review and approval by the project's team.
# Please verify address ranges, naming conventions, and requirements before deployment.

module "snet-vdi-int-com-001" {
  source                = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name                  = "snet-vdi-int-com-001"
  resource_group_name   = module.rg-vdi-int-scl-001-prod-01.name
  virtual_network_name  = module.vnet-vdi-int-scl-001.name
  address_prefix        = ["10.135.160.0/19"]
}

module "snet-vdi-int-win-001" {
  source                = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name                  = "snet-vdi-int-win-001"
  resource_group_name   = module.rg-vdi-int-scl-001-prod-01.name
  virtual_network_name  = module.vnet-vdi-int-scl-001.name
  address_prefix        = ["10.135.192.0/19"]
}

module "snet-vdi-int-otros-001" {
  source                = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name                  = "snet-vdi-int-otros-001"
  resource_group_name   = module.rg-vdi-int-scl-001-prod-01.name
  virtual_network_name  = module.vnet-vdi-int-scl-001.name
  address_prefix        = ["10.135.224.0/19"]
}