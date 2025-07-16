resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
}

#Cambios aplicados

resource "azurerm_role_assignment" "example" {
  scope              = azurerm_resource_group.rg.id
  role_definition_id = var.role_definition_id  # ID del rol User Access Administrator
  principal_id       = var.principal_id  # ID del grupo AZ_DVT_PP_000_RG_DEV_CNTB
}