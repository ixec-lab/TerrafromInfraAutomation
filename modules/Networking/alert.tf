resource "azurerm_monitor_metric_alert" "Request_Count_Alert" {
  name                = "Request_Count_Alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_application_gateway.network.id]
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