#########################################################################
# Default
#########################################################################

variable "channel" {
  type        = "string"
  description = "With which channel the website is associated"
}

variable "dns_suffix" {
  type        = "string"
  description = "The suffix to append to the internal cd.chef.co subdomain"
}
