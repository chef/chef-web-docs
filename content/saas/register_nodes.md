+++
title = "Register Existing Nodes to Chef SaaS Environment"
draft = false
[menu]
  [menu.saas]
    title = "Register Nodes"
    identifier = "chef_infra/Register Nodes to Chef SaaS Environment"
    parent = "chef_saas"
    weight = 50
+++

Once everything has been set up and restored to the new Chef environment, the nodes under management must be redirected from AWS OpsWorks to Chef SaaS. This guide will provide recommendations on how to accomplish this.

## Prerequisites

Before you start working on the Chef environment of Chef SaaS, have a quick look to the following prerequisites:

* Running Automate 2.0 in AWS OpsWorks.
* A Chef SaaS Environment. For more information, refer to the [Getting Started](/get_started/) with the Chef SaaS page.
* Restoration is performed on AWS OpsWorks for Chef SaaS.
* Splay mode and baseline are up to 2 client runs an hour. Refer to the [Chef Infra Client](https://docs.chef.io/ctl_chef_client/) page for more details on configuring splay mode in the `client.rb` file.
* One compliance scan an hour.

## Redirect nodes to Chef SaaS

Progress Chef has developed a Cookbook and Recipe that can run against all nodes under management in the AWS OpsWorks environment. This Cookbook will redirect all nodes to the new Chef SaaS instance. Some samples of the cookbooks, PolicyFile.rb, attribute file, and recipe file, are:

* Cookbook

{{< figure src="/images/saas-cookbook-folder.png" alt="Cookbook Folder">}}

* PolicyFile.rb

```ruby
# Policyfile.rb  Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfule feature, visit https://docs.chef.io/policyfile

# A name that describes the system you're building with Chef docs.
name 'your_client'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef_client will run their recipes in the order specified.
run_list 'your_client::default'

# Specify a custom source for a single cookbook:
cookbook 'your_client', path: '.'
```

* Attribute

{{< figure src="/images/saas-attributes-folder.png" alt="Attributes Folder">}}

`default[‘your_client']['chef_server_old'] = ‘<Old chef-server URL>’`
`default[‘your_client']['chef_server_new'] = ‘<New chef-server URL>'`

* Recipe

{{< figure src="/images/saas-recipes-folder.png" alt="Recipes Folder">}}
