module "vnet-dcprd-scl-001" {
  source              = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name                = "vnet-dcprd-scl-001"
  location            = "chilecentral"
  resource_group_name = data.rg-prd-scl-dc-001.name
  address_space       = ["10.133.9.0/24"]
}

# ===========================
#     DOMAIN CONTROLLER
# ===========================

module "snet-dcprd-addc-001" {
  source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on           = [module.vnet-dcprd-scl-001]
  name                 = "snet-dcprd-addc-001"
  resource_group_name  = data.rg-prd-scl-dc-001.name
  virtual_network_name = module.vnet-dcprd-scl-001.name
  address_prefix       = ["10.133.9.0/26"]
}