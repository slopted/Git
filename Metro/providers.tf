terraform {
  required_version = ">=1.2"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~>4.1.0"
    }
  }
}

/*provider "azurerm" {
  features {}
  use_msi = true
  tenant_id = "b48ab4ae-3a17-4d36-904f-eb39bc4ead7c"
  subscription_id = "91e94169-97ba-46ec-8ef5-b6536ddfec89"
}*/


provider "azurerm" {
  features {}
    client_id       = "fb5b7dc3-efe9-434e-b065-8005007b6b32"
    tenant_id       = "b48ab4ae-3a17-4d36-904f-eb39bc4ead7c"
    subscription_id = "91e94169-97ba-46ec-8ef5-b6536ddfec89"

}