+++
title = "Chef and Terraform"
draft = false

aliases = ["/terraform.html"]

+++

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/terraform.md)

[Terraform](https://www.terraform.io/) is an open source infrastructure as code provisioning tool from [HashiCorp](https://www.hashicorp.com/). Terraform allows you to write code to define and provision infrastructure for the cloud, virtualization, and on premises. Terraform is not a configuration management tool, it is responsible for deploying, maintaining, and destroying the infrastructure that servers and applications run on. When Terraform creates cloud or virtual servers, it uses [Provisioners](https://www.terraform.io/docs/provisioners/index.html) to enable configuration management to manage them. When Terraform talks to APIs to define or configure resources, it uses [Providers](https://www.terraform.io/docs/providers/index.html) to request those resources.

Terraform Integrations
======================

* The [Chef Provisioner](/terraform_provisioner/) bootstraps Terraform-provisioned nodes with Chef Infra which manages their configuration.
* The [Chef Provider](/terraform_provider/) allows management of Chef Infra Server resources (nodes, data bags, etc.) via the API.
* The [Habitat Provisioner](https://www.habitat.sh/docs/habitat-and-other-software/#habitat-and-provisioning) may be used to install and load the Chef Habitat Supervisor and configure the services to be managed by the supervisor.
* [Kitchen Terraform](https://newcontext-oss.github.io/kitchen-terraform/) is a community [Test Kitchen](/kitchen/) driver that allows for multi-node testing.
* [InSpec-Iggy](https://github.com/mattray/inspec-iggy/) is a community [InSpec](https://www.inspec.io/) plugin that generates InSpec compliance controls and profiles from Terraform `tfstate` files and AWS CloudFormation templates.
