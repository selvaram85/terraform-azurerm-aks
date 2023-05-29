
locals {
  resource_tags = {
    project_name = "mytest",
    category     = "UAT"
  }
 resource_basename = "${var.business-division}-${var.location}-${var.project-name}"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                        = "kv-${local.resource_basename}"
  location                    = var.location
  resource_group_name         = var.rgname
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  enable_rbac_authorization   = true
  sku_name = "standard"
  tags = local.resource_tags

}

resource "azurerm_key_vault_secret" "example" {
  name         = var.client_id
  value        = var.client_secret
  key_vault_id = azurerm_key_vault.kv.id
}

