locals {
  env = {
    global = {
      tags = {
        Workspace        = terraform.workspace
        Matter           = "0001-00065"
        Purpose          = "SNS to Slack integration"
        Project          = "AWS Platform"
        Function         = "SNS to Slack integration"
      }
    }

    aonsw-mgmt-sns-slack-cmd = {
      aws_profile             = "hoitcs-api"
      aws_region              = "us-east-1"
    }

    guardduty = {
      aws_profile             = "hoitcs-api"
      aws_region              = "us-east-1"
    }

  }
     #workspace = local.env[terraform.workspace]
}
