data "aws_ssm_parameter" "cloud_dist" {
  count = var.create_domain ? 1 : 0 # only create at the later stage of the pipeline
  name = "/devportal/${var.short_region}/${var.stage}/${var.brand}/cloudfrontdist"
}

data "aws_ssm_parameter" "api_id" {
  count = var.create_domain ? 1 : 0 # only create at the later stage of the pipeline
  name = "/devportal/${var.short_region}/${var.stage}/${var.brand}/apiId"
}

data "aws_acm_certificate" "acm_cert" {
  provider = aws.route53

  domain      = "rbictg.com"
  statuses    = ["ISSUED"]
  most_recent = true
}

data "aws_route53_zone" "r53_zone" {
  provider = aws.route53

  name = "rbictg.com."
}

resource "aws_route53_record" "r53_record" {
  count = var.create_domain ? 1 : 0 # only create at the later stage of the pipeline

  provider = aws.route53

  name    = local.cf_domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.r53_zone.zone_id

  alias {
    name = data.aws_ssm_parameter.cloud_dist.id
    zone_id = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}


resource "aws_api_gateway_domain_name" "rest_domain" {
  count = var.create_domain ? 1 : 0 # only create at the later stage of the pipeline
  domain_name = "${var.short_region}-${var.stage}-${var.brand}-devportal.rbictg.com"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  # Create a domain for API Gateway
  regional_certificate_arn = data.aws_acm_certificate.acm_cert
}

resource "aws_api_gateway_base_path_mapping" "stage_base_mapping" {
  count = var.create_domain ? 1 : 0 # only create at the later stage of the pipeline
  api_id      = data.aws_ssm_parameter.api_id
  stage_name  = "prod"
  domain_name = aws_api_gateway_domain_name.rest_domain[0].domain_name
}