module "notify_slack" {
  source = "./aws-notify-slack-master"

  for_each = toset([
    "main",
    #"dev",
    #"test",
  ])

  sns_topic_name          = "cmd-guardduty-notifications"
  sns_topic_access_policy = ""
  lambda_function_name    = "guardduty-notify-slack-${each.value}"
  slack_webhook_url       = "https://hooks.slack.com/services/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"#aws_kms_ciphertext.slack_url.ciphertext_blob
  slack_channel           = "training"
  slack_emoji             = ":aws:"
  slack_username          = "Hoitcs-guardduty"
  kms_key_arn             = aws_kms_key.this.arn
  lambda_description      = "SNS message forwarding function for CMD Slack"
  log_events              = true
  tags = {
    Name = "cloudwatch-alerts-to-slack"
  }
}

resource "aws_kms_key" "this" {
  description = "KMS key for notify-slack lambda"
}

# Encrypt the URL, storing encryption here will show it in logs and in tfstate
# https://www.terraform.io/docs/state/sensitive-data.html
# resource "aws_kms_ciphertext" "slack_url" {
#   plaintext = data.aws_ssm_parameter.ssm_parameter_cmd_slack_webhook.value
#   key_id    = aws_kms_key.this.arn
# }

resource "aws_cloudwatch_metric_alarm" "lambda_duration" {
  alarm_name          = "NotifySlackDuration"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "Duration"
  namespace           = "AWS/Lambda"
  period              = "60"
  statistic           = "Average"
  threshold           = "5000"
  alarm_description   = "Duration of notifying slack exceeds threshold"

  alarm_actions = [module.notify_slack["main"].this_slack_topic_arn]

  dimensions = {
    FunctionName = module.notify_slack["main"].notify_slack_lambda_function_name
  }
}