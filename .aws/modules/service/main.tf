locals {
  account_id   = module.platform.account_id
  partition    = module.platform.partition
  region       = module.platform.region
  region_short = module.platform.region_short

  app_name          = "developer-portal"
  prefix            = "${module.platform.region_short}-${var.prefix != null ? var.prefix : var.stage}-${var.brand}-${local.app_name}"

  # Example domain: eu-sandbox-plk-devportal.rbictg.com
  cf_domain_name = (var.isPreview == false && var.subdomain != null
    ? join("", [local.region_short != "use1" ? "${substr(local.region_short, 0, 2)}-" : "", var.subdomain, ".", var.domain])
    : null
  )

  common_env_vars = {
    AWS_NODEJS_CONNECTION_REUSE_ENABLED = 1
    AWS_ACCOUNT_ID                      = local.account_id
    BRAND                               = var.brand
    NO_COLOR                            = "true"
    STAGE                               = var.stage
    LOG_LEVEL                           = var.log_level
  }

  tags = {
    app     = local.app_name
    brand   = var.brand
    stage   = var.stage
    env     = var.stage
    service = local.app_name

    "rbi:brand"   = var.brand
    "rbi:service" = local.app_name
    "rbi:stage"   = var.stage
    "rbi:source"  = "terraform"
  }
}

module "platform" {
  source = "git@github.com:rbilabs/ctg-devops//modules/platform?ref=1.0.257"
}