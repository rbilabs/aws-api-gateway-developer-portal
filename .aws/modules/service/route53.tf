data "aws_ssm_parameter" "ami" {
  name = "/devportal/${var.short_region}/${var.stage}/${var.brand}/cloudfrontdist"
}
/* 
data "aws_acm_certificate" "acm_cert" {
  count = var.create_domain ? 1 : 0 # only create at the later stage of the pipeline
  provider = aws.acm

  domain      = var.domain
  statuses    = ["ISSUED"]
  most_recent = true
}

data "aws_route53_zone" "r53_zone" {
  provider = aws.route53

  name = "${var.domain}."
}

resource "aws_route53_record" "r53_record" {
  count = var.create_domain ? 1 : 0 # only create at the later stage of the pipeline

  provider = aws.route53

  name    = local.cf_domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.r53_zone.zone_id

  records = [
      data.aws_ssm_parameter.id
  ]
} */
