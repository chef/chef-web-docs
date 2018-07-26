#########################################################################
# Default
#########################################################################
variable "environment" {
  type        = "string"
  default     = "dev"
  description = "The common name of the environment"
}

variable "vpc" {
  type        = "string"
  default     = "dev-1"
  description = "The VPC in which the app is being deployed"
}

variable "www_dns" {
  type        = "string"
  description = "The prefix of the DNS for the www site"
}

variable "build_command" {
  type        = "string"
  default     = ""
  description = "The command used to build the static site"
}

variable "fastly_fqdn" {
  type        = "string"
  default     = ""
  description = "The Fastly service FQDN (leave empty to disable)"
}
