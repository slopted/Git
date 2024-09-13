import {
  to = azurerm_resource_group.rg-POCMetroProd-001
  id = "/subscriptions/91e94169-97ba-46ec-8ef5-b6536ddfec89/resourceGroups/rg-POCMetroProd-001"
}

resource "azurerm_resource_group" "rg-POCMetroProd-001" {
  name     = local.rg_name
  location = var.DefaultLocation
}

resource "azurerm_virtual_network" "vnet-POCMetroProd-001" {
  name                = local.vnet_name
  location            = azurerm_resource_group.rg-POCMetroProd-001.location
  resource_group_name = azurerm_resource_group.rg-POCMetroProd-001.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}
resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.rg-POCMetroProd-001.name
  virtual_network_name = azurerm_virtual_network.vnet-POCMetroProd-001.name
  address_prefixes     = ["10.0.1.0/24"]
}