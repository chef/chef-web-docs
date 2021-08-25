+++
title = "Set up a quick demo"
draft = false

[menu]
  [menu.desktop]
    title = "Quick Start guide"
    identifier = "desktop/install/demonstration_setup.md Set up a demo with the quick setup repository"
    parent = "desktop/install"
    weight = 10
+++

This section is dedicated towards helping you set up a demonstration setup that you can use for evaluating a trial version of our product. If you want to set up Chef Desktop product for production use, we recommend you to set up the components of the Chef Desktop pattern by following the instructions provided in their respective pages in the Setup and Installation section for Chef Desktop on this website.

You can either follow the instructions provided here, or if you want a more comprehensive documentation and understand the modules better, read the code or see more ways how to use them, you can visit the [repository on GitHub](https://github.com/chef/chef-desktop-quick-setup) and check out [the wiki page](https://github.com/chef/chef-desktop-quick-setup/wiki).

## Setting up the local system

To make this easier for you, we have written some Terraform modules that you can run on your system to create a demonstration setup on AWS cloud.

But before we start using these modules, we would first need to set up our local workstation.

**Note**: All the tools required for installation are solely for the purpose of automating the process so that you don't have to spend time doing it yourself. Chef Desktop can be set up without the use of the terraform modules provided or the tools required to run these modules, and we would recommend doing it that way for production.

### Set up the modules on your local system

There are two ways we can get the modules:

1. We can download the modules directly from [this link](https://github.com/chef/chef-desktop-quick-setup/archive/refs/heads/master.zip), or
1. Clone it from the public repository on GitHub.

To get the modules from the public GitHub repository, with the git tool installed in your system, run this on the command line:

```powershell
git clone https://github.com/chef/chef-desktop-quick-setup
```

Now we will install the tools required to support the modules:

1. [Chef Workstation](https://downloads.chef.io/tools/workstation): Installs the chef tools necessary to create the chef repo, install cookbooks, push policies to the created server, and setup local chef configuration.
1. [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli): To run the modules.
1. [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html): Terraform needs this to be able to communicate to the cloud provider. Read more about it in their documentation.
1. PuTTy for Windows: Terraform modules will use this to get the keys from your server or perform actions that you would otherwise manually do.

### Set up the cloud provider configuration in your system

To create the instances in the cloud through Terraform, we'd need to make sure we are logged in through the command line tool for our cloud provider. For AWS, we can install AWS CLI and follow their login instructions. More information is provided on Terraform's documentation and [tutorials](https://learn.hashicorp.com/terraform) for infrastructure provisioning.

### Run the modules

Once the CLI is configured, you can now navigate to the `aws` directory where we have the files for AWS. Next, rename the file `terraform.tfvars.example` to `terraform.tfvars`. That's it. Now we will run the following command that will create an Automate server and set up virtual nodes/endpoints running Windows.

_**Note:** There's a lot more we can do with these modules, like setting up application management and compliance demo as well, for which you can read our Wiki page in the repository for more details. For the sake of simplicity, we are going through the quickest flow._

```powershell
terraform apply -target=module.automate -target=module.nodes
```

This will set up the server, create a chef repo with the free version of Chef Desktop cookbook, push a policy to server, create a node and apply the policy to it and run chef client on it. Once the process is complete, we can access the dashboard to see the report.

### Verify the setup and access the dashboard

In the repository that you cloned, you can find a `keys` directory. In there, you can find a the credentials file named `automate-credentials.toml`. Visit the URL provided in that file and login to your automate dashboard with the username and password given there. The URL is the elastic IP of the EC2 instance we created and set up our Automate Server with Chef Desktop product.