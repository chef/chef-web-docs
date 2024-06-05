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

Once everything has been set up and restored to the new Chef environment, redirect the nodes under management from AWS OpsWorks to Chef SaaS. This guide will provide recommendations on how to accomplish this.

## Prerequisites

Before you start working on the Chef environment of Chef SaaS, have a quick look at the following prerequisites:

- Running Chef Automate 2.0 in AWS OpsWorks.
- A Chef SaaS Environment. Refer to the [Getting Started](/saas/get_started/) with the Chef SaaS page for more information.
- Restoration is performed on AWS OpsWorks for Chef SaaS.
- Splay mode and baseline are up to two client runs an hour. Refer to the [Chef Infra Client](/ctl_chef_client/) page for more details on configuring splay mode in the `client.rb` file.
- One compliance scan an hour.

## Redirect nodes to Chef SaaS

Progress Chef has developed a Cookbook and Recipe that can run against all nodes under management in the AWS OpsWorks environment. This Cookbook will redirect all nodes to the new Chef SaaS instance. Some samples of the cookbooks, PolicyFile.rb, attribute file, and recipe file, are:

To redirect nodes from AWS OpsWorks to Chef SaaS:

1. Create a [new cookbook](/cookbooks/#generate-a-cookbook).
1. Update the [Policyfile](/config_rb_policyfile/) with the following content:

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

1. Add attributes for the new and old server:

    `default['your_client']['chef_server_old'] = '<OLD_CHEF_SERVER_URL>'`
    `default['your_client']['chef_server_new'] = '<NEW_CHEF_SERVER_URL>'`

1. Upload the new cookbook to your server on AWS OpsWorks.
1. Log into Chef SaaS after the next Infra Client run to verify that the nodes have redirect to Chef SaaS.

Contact your SA if you need help.
