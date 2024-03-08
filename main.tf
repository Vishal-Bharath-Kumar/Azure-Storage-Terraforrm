resource "azurerm_resource_group" "az_resource_grp" {
  name     = var.resource_group_name
  location = "East US"
}
resource "azurerm_storage_account" "az_storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.az_resource_grp.name
  location                 = azurerm_resource_group.az_resource_grp.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
resource "azurerm_storage_container" "az_storage_container" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.az_storage_account.name
  container_access_type = "private"
}
resource "azurerm_storage_blob" "az_storage_blob" {
  name                   = var.storage_blob_name
  storage_account_name   = azurerm_storage_account.az_storage_account.name
  storage_container_name = azurerm_storage_container.az_storage_container.name
  type                   = "Block"
  content_type           = "image/jpeg"
  source                 = "Vishal.jpeg"
  depends_on = [azurerm_storage_container.az_storage_container]
}