terraform {
  backend "azurerm" {
    resource_group_name  = "rg-vm-app-prod-000"
    storage_account_name = "terraformprodas"
    container_name = "tfstates"
    key = "azure.terraform.prod.testusr.rg.rgprodtestusr01.state"
  }
}

/*
State Naming Convention Documentation

This file defines the naming convention for Terraform state files used in this project.

Naming Pattern:
  <csp>.<IAC_Language>.<environment>.<provider>.<rg>.<resource_group_name>.<state>

Where:
  - <csp>: Cloud Service Provider (e.g., Azure, AWS, GCP)
  - <IAC_Language>: Infrastructure as Code language (e.g., Terraform)
  - <environment>: Deployment environment (e.g., Test, QA, Prod)
  - <provider>: Provider name (e.g., AzureRM)
  - <rg>: Resource Group abbreviation
  - <resource_group_name>: Name of the resource group
  - <state>: State file extension

Variables:
  - <csp>
  - <environment>
  - <resource_group_name>

Constants:
  - <IAC_Language>
  - <provider>
  - <rg>
  - <state>
*/