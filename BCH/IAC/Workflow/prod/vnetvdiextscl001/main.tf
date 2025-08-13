module "vnet-vdi-ext-scl-001" {
  source              = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name                = "vnet-vdi-ext-scl-001"
  location            = "chilecentral"
  resource_group_name = data.rg-prd-scl-vdi-ext-001.name
  address_space       = ["10.135.128.0/22"]
}


# ==========================================================
#  ESCRITORIOS AVD EXTERNOS (850 USUARIOS)
# ==========================================================

module "snet-vdi-ext-001" {
  source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name                 = "snet-vdi-ext-001"
  resource_group_name  = data.rg-prd-scl-vdi-ext-001.name
  virtual_network_name = module.vnet-vdi-ext-scl-001.name
  address_prefix       = ["10.135.128.0/22"]
}