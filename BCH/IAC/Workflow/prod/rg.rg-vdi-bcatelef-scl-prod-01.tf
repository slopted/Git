module "rg-vdi-bcatelef-scl-prod-01" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group"
  name     = "rg-vdi-bcatelef-scl-prod-01"
  location = "chilecentral"
}

module "vnet-vdi-bcatelef-scl-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-vdi-bcatelef-scl-001"
  location = "chilecentral"
  resource_group_name = module.rg-vdi-bcatelef-scl-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  address_space = ["10.135.132.0/22"]
}

# ==========================================================
#  Escritorios AVD Bca. Telefónica (524 Usuarios)
# ==========================================================

# WARNING: The following Azure Escritorios AVD internos USA (100 Usuarios) subnet configuration is pending review and approval by the project's team.
# Please verify address ranges, naming conventions, and requirements before deployment.

module "snet-vdi-bcatelef-001" {
  source                = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name                  = "snet-vdi-bcatelef-001"
  resource_group_name   = module.rg-vdi-bcatelef-scl-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name  = module.vnet-vdi-bcatelef-scl-001.name
  address_prefix        = ["10.135.132.0/22"] 
}