/*
State Naming Convention Documentation

This file defines the naming convention for Terraform state files used in this project.

Naming Pattern:
  <csp>.<IAC_Language>.<environment>.<Project|Bussiness>.<Resource_Abbreviation>.<resource_group_name>.<state>

Where:
  - <csp>: Cloud Service Provider (e.g., Azure, AWS, GCP)
  - <IAC_Language>: Infrastructure as Code language (e.g., Terraform)
  - <environment>: Deployment environment (e.g., Test, QA, Prod)
  - <Project|Bussiness>: Name of the project or business unit (e.g., fani, lsc, murex)
  - <Resource_Abbreviation>: Resource Abbreviation (e.g., rg, vnet, vm)
  - <Resource_Name>: Name of the resource.
  - <state>: State file extension.

Variables:
  - <csp>
  - <environment>
  - <Project|Bussiness>
  - <Resource_Abbreviation>
  - <Resource_Name>
  - <resource_group_name>

Constants:
  - <IAC_Language>
  - <state>
*/

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-vm-app-prod-000"
    storage_account_name = "terraformprodas"
    container_name       = "tfstates"
    key                  = "azure.terraform.prod.testusr.rg.rg-prd-scl-bkp-001.state"
  }
}