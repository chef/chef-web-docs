#########################################################################
# Non production chef-web-docs s3 static site bucket
#########################################################################

module "chef-web-docs" {
  source      = "git@github.com:chef/es-terraform.git//modules/cd_s3_website"
  subdomain   = "chef-web-docs${var.environment == "delivered" ? "" : "-${var.environment}"}"
  tag_contact = "releng"
}
