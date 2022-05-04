variable "brand" {
  description = "Application Brand"
  type        = string
}

variable "prefix" {
  description = "Resource prefix"
  default     = null
}

variable "region" {
  description = "The AWS Region"
  type        = string
  default     = "us-east-1"
}


variable "short_region" {
  description = "The AWS Short Region"
  type        = string
  default     = "use1"
}

variable "stage" {
  description = "Application Brand"
  type        = string
}

variable "log_level" {
  description = "Log level"
  type        = string
}


variable "create_domain" {
  description = "Create domain for developer portal"
  type        = bool
  default = false
}
