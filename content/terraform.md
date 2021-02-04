+++
title = "Chef and Terraform"
draft = false

gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Chef and Terraform"
    identifier = "chef_infra/getting_started/terraform.md Chef and Terraform"
    parent = "chef_infra/getting_started"
    weight = 60
+++

[Terraform](https://www.terraform.io/) is an open-source infrastructure-as-code provisioning tool from [HashiCorp](https://www.hashicorp.com/). Terraform allows you to write code to define and provision infrastructure for the cloud, virtual machines, and on-premises machines. Terraform is not a configuration management tool, it is responsible for deploying, maintaining, and destroying the infrastructure that servers and applications run on. When Terraform creates cloud or virtual servers, it uses [Provisioners](https://www.terraform.io/docs/provisioners/index.html) to enable configuration management to manage them. When Terraform talks to APIs to define or configure resources, it uses [Providers](https://www.terraform.io/docs/providers/index.html) to request those resources.

### Terraform and Chef Solo

If you are using [Chef Solo](/chef_solo/), you will most likely want to use the [Terraform remote-exec Provisioner](https://www.terraform.io/docs/provisioners/remote-exec.html) rather than the Terraform Chef Provisioner.
## Chef Infra Provider

The [Terraform Chef Provider](https://www.terraform.io/docs/providers/chef/index.html) allows you to manage Chef Infra Server resources (nodes, data bags, etc.) using the Chef Infra Server API. Policyfiles, cookbooks, clients, and ACLs are not currently managed with the Provider. The [Terraform Chef Provider documentation](https://www.terraform.io/docs/providers/chef/index.html) provides a complete list of supported options and an example of usage. HashiCorp provides support for the Terraform Chef Provider and it is not officially supported by Chef Software.

## Additional Terraform Integrations

* [Kitchen Terraform](https://newcontext-oss.github.io/kitchen-terraform/) is a community [Test Kitchen](/kitchen/) driver that allows for multi-node testing.
* [InSpec-Iggy](https://github.com/mattray/inspec-iggy/) is a community [InSpec](/inspec/) plugin that generates InSpec compliance controls and profiles from Terraform `tfstate` files and AWS CloudFormation templates.
