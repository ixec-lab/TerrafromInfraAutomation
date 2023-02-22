# Setting up alams : alarm fire when requests to load balancer > 10

resource "aws_sns_topic" "requests_alarm" {
  name = "alarm_topic"
}

resource "aws_cloudwatch_metric_alarm" "requests_alarm" {
  alarm_name          = "RequestsAlarmGeaterThan10"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "RequestCount"
  namespace           = "AWS/NetworkELB"
  period              = "60"
  statistic           = "SampleCount"
  datapoints_to_alarm  = 1
  threshold           = "10"
  actions_enabled     = true
  insufficient_data_actions = []
  alarm_description   = "This metric checks the number of requests to the application in one minute"
  alarm_actions       = [aws_sns_topic.requests_alarm.arn]
  ok_actions = []
  treat_missing_data = "breaching"

  dimensions = {
    TargetGroup  = aws_lb_target_group.http.arn_suffix
    LoadBalancer = aws_lb.load_balancer.arn_suffix
  }

}