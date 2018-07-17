provider "aws" {
  region  = "${var.aws_region}"
  profile = "chef-cd"
}

module "cd_infrastructure" {
  source      = "git@github.com:chef/es-terraform.git//modules/cd_common_infrastructure"
  environment = "${var.environment}"
}
