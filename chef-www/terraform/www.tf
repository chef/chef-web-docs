module "hugo_site" {
  source               = "git@github.com:chef/es-terraform.git//modules/cd_hugo_static_site"
  subdomain            = "${var.www_dns}"
  site_dir             = "../site"
  build_command        = "${var.build_command}"
  fastly_fqdn          = "${var.fastly_fqdn}"
  redirect_apex_to_www = "${var.www_redirect}"
}
