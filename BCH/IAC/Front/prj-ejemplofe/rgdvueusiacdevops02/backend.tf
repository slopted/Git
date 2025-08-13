terraform {
  backend "azurerm" {
    resource_group_name  = "rg-vm-app-dev-000"
    storage_account_name = "terraformdevas"
    container_name = "tfstates"
    key = "azure.terraform.dev.dsoiac.rg.rgdviacdso02.state"
  }
}