module "rg-sql-01" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group"
  name     = "rg-sql-01"
  location = "chilecentral"
}

module "vnet-sql" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-sql"
  location = "chilecentral"
  resource_group_name = module.rg-sql-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  address_space = ["10.134.64.0/23"]
}

# ===========================
# SQL Server
# ===========================

module "snet-TBD-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-TBD-001"
  resource_group_name = module.rg-sql-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-sql.name
  address_prefix = ["10.134.64.0/25"]
}

module "snet-TBD-002" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-TBD-002"
  resource_group_name = module.rg-sql-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-sql.name
  address_prefix = ["10.134.64.128/25"]
}

module "snet-TBD-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  name     = "snet-TBD-001"
  resource_group_name = module.rg-sql-01.name #UPDATE WITH THE RESOURCE GROUP NAME
  virtual_network_name = module.vnet-sql.name
  address_prefix = ["10.134.65.0/25"]
}