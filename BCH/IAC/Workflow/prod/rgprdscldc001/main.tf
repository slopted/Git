module "rg-prd-scl-dc-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group"
  name     = "rg-prd-scl-dc-001"
  location = "chilecentral"
}