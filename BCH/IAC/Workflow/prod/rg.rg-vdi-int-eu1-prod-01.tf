module "rg-vdi-int-eu1-prod-01" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group"
  name     = "rg-vdi-int-eu1-prod-01"
  location = "chilecentral"
}

module "vnet-vdi-int-eu1-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-vdi-int-eu1-001"
  location = "chilecentral"
  resource_group_name = module.rg-vdi-int-eu1-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  address_space = [TBD] # Define the address space as per your requirements
}

# ==========================================================
#  Escritorios AVD internos USA (100 Usuarios)
# ==========================================================

# WARNING: The following Azure Escritorios AVD internos USA (100 Usuarios) subnet configuration is pending review and approval by the project's team.
# Please verify address ranges, naming conventions, and requirements before deployment.

module "TBD1" {
  source                = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name                  = "TBD1"
  resource_group_name   = module.rg-vdi-int-eu1-prod-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name  = module.vnet-vdi-int-eu1-001.name
  address_prefix        = [TBD1] # Define the address prefix as per your requirements
}