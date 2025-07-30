module "vnet-sql" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-sql"
  location = "chilecentral"
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-sql-001
  address_space = ["10.134.64.0/23"]
}

# ===========================
# SQL Server
# ===========================

module "snet-sql-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on = [ module.vnet-sql ]
  name     = "snet-sql-001"
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-sql-001
  virtual_network_name = module.vnet-sql.name
  address_prefix = ["10.134.64.0/25"]
}

module "snet-sql-002" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on = [ module.vnet-sql ]
  name     = "snet-sql-002"
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-sql-001
  virtual_network_name = module.vnet-sql.name
  address_prefix = ["10.134.64.128/25"]
}

module "snet-sql-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on = [ module.vnet-sql ]
  name     = "snet-sql-001"
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-sql-001
  virtual_network_name = module.vnet-sql.name
  address_prefix = ["10.134.65.0/25"]
}