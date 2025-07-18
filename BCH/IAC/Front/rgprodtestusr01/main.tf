module "azurerm_resource_group" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group"
  name     = "rg-prod-testusr-01"
  location = "eastus"
}
