terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.71"
      configuration_aliases = [ aws.route53 ]
    }
  }
}
