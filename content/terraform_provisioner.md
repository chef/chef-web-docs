+++
title = "Terraform Chef Provisioner"
draft = false

aliases = ["/terraform_provisioner.html"]

+++

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/terraform_provisioner.md)

[Terraform](https://www.terraform.io/) is an open source infrastructure as code provisioning tool from [HashiCorp](https://www.hashicorp.com/). While Terraform allows you to define and provision supporting infrastructure as code Terraform is not a configuration management tool. When Terraform creates servers, it uses [Provisioners](https://www.terraform.io/docs/provisioners/index.html) to enable configuration management to manage them.

If you want to manage resources on the Chef Infra Server with Terraform, check out the [Terraform Chef Provider](/terraform_provider/).

Chef Infra Provisioner
======================

HashiCorp provides documentation and support for the [Terraform Chef Provisioner](https://www.terraform.io/docs/provisioners/chef.html) and it is not officially supported by Chef Software. The Terraform Chef Provisioner bootstraps nodes with Chef Infra via SSH or WinRM and configures them to work with a [Chef Infra Server](/server_overview/). Standard bootstrap options such as Chef Infra versions, secrets, proxies, and assigning run lists via Policyfiles or Roles and Environments are all supported. The referenced documentation provides a complete list of supported options and an example of usage.

## Terraform and Chef Solo ##

If you are using [Chef Solo](/chef_solo/) you will most likely want to use the [Terraform remote-exec Provisioner](https://www.terraform.io/docs/provisioners/remote-exec.html) rather than the Terraform Chef Provsioner. The remote-exec Provisioner may be used to run a script or an inline set of commands on the newly created machine. Please refer to the [Terraform remote-exec Provisioner documentation](https://www.terraform.io/docs/provisioners/remote-exec.html) for further options and examples.


### Example remote-exec inline ###

```
resource "aws_instance" "web" {
  # ...

  provisioner "remote-exec" {
    inline = [
      "wget -O /tmp/chef.rpm https://MYSERVER/chef_installers/chef-15.8.23-1.el7.x86_64.rpm",
      "rpm -Uvh /tmp/chef.rpm",
      "wget -O /tmp/base.tgz https://MYSERVER/policyfiles/base.tgz",
      "tar -C /tmp -xzf /tmp/base.tgz",
      "PWD=/tmp/base chef-client -z",
    ]
  }
}
```
