module "azurerm_resource_group" {
  source   = "git::http://bitbucket.bch.bancodechile.cl:7990/scm/aziacbe/mod_resource_group.git"
  name     = "az-eastus-dev-rsc-grp-iacdevops-02"
  location = "eastus"
}
