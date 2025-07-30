module "rg-pp-scl-bkp-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group"
  name     = "rg-pp-scl-bkp-001"
  location = "chilecentral"
}