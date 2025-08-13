module "rg-pp-scl-sql-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group"
  name     = "rg-pp-scl-sql-001"
  location = "chilecentral"
}