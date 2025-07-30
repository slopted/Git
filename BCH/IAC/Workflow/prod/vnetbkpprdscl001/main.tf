module "vnet-bkpprd-scl-001" {
  source              = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name                = "vnet-bkpprd-scl-001"
  location            = "chilecentral"
  resource_group_name = data.rg-prd-scl-bkp-001.name
  address_space       = ["10.133.10.0/24"]
}

# ===========================
#         VERITAS
# ===========================

module "snet-bkpprd-bkp-001" {
  source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on           = [module.vnet-bkpprd-scl-001]
  name                 = "snet-bkpprd-bkp-001"
  resource_group_name  = data.rg-prd-scl-bkp-001.name
  virtual_network_name = module.vnet-bkpprd-scl-001.name
  address_prefix       = ["10.133.10.0/28"]
}