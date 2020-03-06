+++
title = "Terraform Chef Provider"
draft = false

aliases = ["/terraform_provider.html"]

+++

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/terraform_provider.md)

[Terraform](https://www.terraform.io/) is an open source infrastructure as code provisioning tool from [HashiCorp](https://www.hashicorp.com/). Terraform allows you to write code to define and provision infrastructure for the cloud, virtualization, and on premises. When Terraform talks to APIs to define or configure resources, it uses [Providers](https://www.terraform.io/docs/providers/index.html) to request those resources.

If you want to bootstrap nodes with Chef Infra from Terraform, check out the [Terraform Chef Provisioner](/terraform_provisioner/).

Chef Infra Provider
===================

HashiCorp provides documentation and support for the [Terraform Chef Provider](https://www.terraform.io/docs/providers/chef/index.html) and it is not officially supported by Chef Software. The Terraform Chef Provider allows management of Chef Infra Server nodes, data bags, environments, and roles via the API. Policyfiles, cookbooks, clients, and ACLs are not currently managed via the Provider. The [Terraform Chef Provider documentation](https://www.terraform.io/docs/providers/chef/index.html) provides additional documentation, a complete list of supported options, and an example of usage.
