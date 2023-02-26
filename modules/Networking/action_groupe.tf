resource "azurerm_monitor_action_group" "Action_group" {
  name                = "Action_group"
  resource_group_name = var.resource_group_name
  short_name          = "Action_group"
}
