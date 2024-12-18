+++
title = "Chef and Terraform"
draft = false

gh_repo = "chef-web-docs"
product = ["client", "server"]

[menu]
  [menu.infra]
    title = "Chef and Terraform"
    identifier = "chef_infra/integrations/terraform.md Chef and Terraform"
    parent = "chef_infra/integrations"
    weight = 60
+++

{{< warning >}}
Terraform deprecated the Chef Provisioner in the [0.13.4](https://www.terraform.io/docs/language/resources/provisioners/chef.html) release and they will remove it in a future version. Terraform continues to support the Chef Provider.
{{< /warning >}}

[Terraform](https://www.terraform.io/) is an open-source infrastructure-as-code provisioning tool from [HashiCorp](https://www.hashicorp.com/). Terraform allows you to write code to define and provision infrastructure for the cloud, virtual machines, and on-premises machines. Terraform isn't a configuration management tool, it's responsible for deploying, maintaining, and destroying the infrastructure that servers and applications run on. When Terraform creates cloud or virtual servers, it uses [Provisioners](https://www.terraform.io/docs/provisioners/index.html) to enable configuration management to manage them. When Terraform talks to APIs to define or configure resources, it uses [Providers](https://www.terraform.io/docs/providers/index.html) to request those resources.

## Chef Infra Provisioner

The [Terraform Chef Provisioner](https://www.terraform.io/docs/provisioners/chef.html) bootstraps Terraform, provisioned with Chef Infra using SSH or WinRM, and configures them to work with a [Chef Infra Server](/server/). Standard bootstrap options such as Chef Infra versions, secrets, proxies, and assigning run lists using Policyfiles or Roles and Environments are all supported. The referenced documentation provides a complete list of supported options and an example of usage. HashiCorp provides support for the [Terraform Chef Provisioner](https://www.terraform.io/docs/provisioners/chef.html) and it's not officially supported by Chef Software.

### Terraform and Chef Solo

If you are using [Chef Solo](/chef_solo/), you will most likely want to use the [Terraform remote-exec Provisioner](https://www.terraform.io/docs/provisioners/remote-exec.html) rather than the Terraform Chef Provisioner. The remote-exec Provisioner may be used to run a script or an inline set of commands on the newly created machine. Please refer to the [Terraform remote-exec Provisioner documentation](https://www.terraform.io/docs/provisioners/remote-exec.html) for further options and examples.

#### Example remote-exec inline

```bash
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

## Chef Infra Provider

The [Terraform Chef Provider](https://www.terraform.io/docs/providers/chef/index.html) allows you to manage Chef Infra Server resources (nodes, data bags, etc.) using the Chef Infra Server API. Policyfiles, cookbooks, clients, and ACLs aren't currently managed with the Provider. The [Terraform Chef Provider documentation](https://www.terraform.io/docs/providers/chef/index.html) provides a complete list of supported options and an example of usage. HashiCorp provides support for the Terraform Chef Provider and it's not officially supported by Chef Software.

## Additional Terraform Integrations

* [Kitchen Terraform](https://newcontext-oss.github.io/kitchen-terraform/) is a community [Test Kitchen](/kitchen/) driver that allows for multi-node testing.
