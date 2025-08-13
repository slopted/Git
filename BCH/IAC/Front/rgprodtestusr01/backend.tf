terraform {
  backend "azurerm" {
    resource_group_name  = "rg-vm-app-prod-000"
    storage_account_name = "terraformprodas"
    container_name = "tfstates"
    key = "azure.terraform.prod.testusr.rg.rgprodtestusr01.state"
  }
}