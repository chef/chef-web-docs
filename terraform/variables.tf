#########################################################################
# Default
#########################################################################
# Environment and the associated delivery environment
# Can be one of dev, acceptance, union, rehearsal or delivered
variable "environment" {
  type = "string"
}

#########################################################################
# AWS
#########################################################################
variable "aws_region" {
  type    = "string"
  default = "us-west-2"
}

variable "availability_zones" {
  default = {
    us-west-2 = [
      "us-west-2a",
    ]
  }
}
