terraform {
  #backend "s3" {} # Uncomment this once the backend has been deployed.
   backend "local" {}
 
 
  required_providers {
    aws = {
      version = "4.24.0"
      source  = "hashicorp/aws"
    }
  }
}
# provider "aws" {
#   region = "us-east-1"
#   profile = "hoitcs-api"
#   #profile = "vscode"
# }
provider "aws" {
  profile = "hoitcs-api"                                                 #local.workspace["aws_profile"]
  region  = "us-east-1"
  access_key = ""                   #var.AWS_ACCESS_KEY_ID
  secret_key = ""

    default_tags {
      tags = {
        # Repository       = local.env["global"]["tags"]["Repository"]
        Workspace        = local.env["global"]["tags"]["Workspace"]
        Matter           = local.env["global"]["tags"]["Matter"]
        Purpose          = local.env["global"]["tags"]["Purpose"]
        Project          = local.env["global"]["tags"]["Project"]
        Function         = local.env["global"]["tags"]["Function"]
        # BusinessOwner    = local.env["global"]["tags"]["BusinessOwner"]
        # ResponsibleParty = local.env["global"]["tags"]["ResponsibleParty"]
    }
  }
}
