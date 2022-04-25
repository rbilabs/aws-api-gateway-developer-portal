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

variable "stage" {
  description = "Application Brand"
  type        = string
}

variable "log_level" {
  description = "Log level"
  type        = string
}
