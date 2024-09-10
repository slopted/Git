variable "DefaultLocation" {
  default     = "eastus"
  description = "Location of the resource group."
}

variable "name_prefix" {
  default     = "POCMetroProd"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}