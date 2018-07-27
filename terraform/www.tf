# The Terraform module we use to build and deploy Hugo sites is generic
# enough to use for building and deploying Sphinx sites!
module "hugo_site" {
  source        = "git@github.com:chef/es-terraform.git//modules/cd_hugo_static_site"
  subdomain     = "${var.www_dns}"
  site_dir      = "../build"
  build_command = "make docs"
  fastly_fqdn   = "${var.fastly_fqdn}"
}
