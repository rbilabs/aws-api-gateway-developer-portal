variable "brand" {
  description = "Application Brand"
  type        = string
}

variable "prefix" {
  description = "Resource prefix"
  default     = null
  type        = string
}

variable "route53_role" {
  default     = "arn:aws:iam::880659461790:role/aws-rbi-account-org-dns"
  description = "(Optional) AWS IAM role to adopt when accessing route 53 zone"
}

variable "stage" {
  description = "Application Brand"
  type        = string
}

variable "log_level" {
  description = "Log level"
  type        = string
  default     = "info"
}
