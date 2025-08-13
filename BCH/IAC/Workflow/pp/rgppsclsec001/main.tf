module "rg-pp-scl-sec-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group"
  name     = "rg-pp-scl-sec-001"
  location = "chilecentral"
}