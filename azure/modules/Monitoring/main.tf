resource "azurerm_monitor_action_group" "Action_group" {
  name                = var.Action_group_name
  resource_group_name = var.resource_group_name
  short_name          = var.Action_group_name
}


resource "azurerm_monitor_metric_alert" "Request_Count_Alert" {

  name                = var.Request_Count_Alert_name
  resource_group_name = var.resource_group_name
  scopes              = [var.Lb-id]
  description         = "Alert triggered when the number of requests > 10"
  enabled             = true
  window_size = "PT1M"

  severity = 2
  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "TotalRequests"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 10
  }

  action {
    action_group_id = azurerm_monitor_action_group.Action_group.id
  }
}