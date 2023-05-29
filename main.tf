terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

locals {
  resource_tags = {
    project_name = "mytest",
    category     = "UAT"
  }
  resource_basename = "${var.business-division}-${var.location}-${var.project-name}"
}

resource "azurerm_resource_group" "rgname" {
  name     = var.rgname
  location = var.location
}


module "serviceprincipal" {
  source                 = "./Service-principal"
  service_principal_name = "terraaks"
}

module "keyvault" {
  source        = "./Key-vault"
  rgname        = azurerm_resource_group.rgname.name
  client_id     = module.serviceprincipal.client_id
  client_secret = module.serviceprincipal.client_secret
    
depends_on = [
   module.serviceprincipal
  ]
}

module "aks" {
source = "./aks"
rgname = var.rgname
location = var.location
client_id     = module.serviceprincipal.client_id
client_secret = module.serviceprincipal.client_secret

 depends_on = [
    module.serviceprincipal
  ]

}

data "azurerm_subscription" "primary" {
}

data "azurerm_client_config" "example" {
}

resource "azurerm_role_assignment" "example" {
  scope                = "/subscriptions/c823ad8e-9245-4295-afbe-310ad5337e97"
  role_definition_name = "Owner"
  principal_id         = module.serviceprincipal.service_principal_object_id
}








