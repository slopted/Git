module "rg-prd-scl-shared-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group"
  name     = "rg-sharedprd-prod-01"
  location = "chilecentral"
}