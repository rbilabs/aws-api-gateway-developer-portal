provider "aws" {
  region = "eu-central-1"
}

provider "aws" {
  alias  = "route53"
  region = "us-east-1"

  assume_role {
    role_arn = var.route53_role
  }
}

terraform {
  required_version = "1.0.3"

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "rbilabs"

    workspaces {
      # default remote workspace
      # this value is overriden during CI runs
      name = "euc1-dev-bk-aws-api-gateway-developer-portal"
    }
  }
}

module "service" {
  source           = "../../../modules/service"
  stage            = var.stage
  brand            = var.brand
  prefix           = var.prefix
  log_level        = var.log_level

  providers = {
    aws.route53 = aws.route53
  }
}
