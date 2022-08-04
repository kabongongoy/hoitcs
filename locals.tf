locals {
  env = {
    global = {
      tags = {
        # Repository       = "ts/aonsw-aws-platform/sns-cmd"
        Workspace        = terraform.workspace
        Matter           = "0001-00065"
        Purpose          = "SNS to Slack integration"
        Project          = "AWS Platform"
        Function         = "SNS to Slack integration"
        # BusinessOwner    = "cio@audit.nsw.gov.au"
        # ResponsibleParty = "cs.technology@audit.nsw.gov.au"
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
