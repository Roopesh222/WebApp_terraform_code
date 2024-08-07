provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group" {
  name     = var.rg_name
  location = var.location
}
resource "azurerm_service_plan" "service_plan" {
  name                = var.service_plan_name
  resource_group_name = var.rg_name
  location            = var.location
  sku_name            = "P1v2"
  os_type             = "Windows"
  depends_on = [ azurerm_resource_group.resource_group ]
}

resource "azurerm_windows_web_app" "web_app" {
  name                = var.web_app_name
  resource_group_name = var.rg_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.service_plan.id
  depends_on = [azurerm_service_plan.service_plan, azurerm_resource_group.resource_group]
  site_config {}
}