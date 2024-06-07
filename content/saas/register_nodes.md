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

When everything has been set up and restored to the new Chef environment, you must redirect the nodes under management from AWS OpsWorks to Chef SaaS. This guide provides recommendations on how to accomplish this.

## Prerequisites

There are some prerequisites to be aware of before you start working on the Chef environment of Chef SaaS:

- AWS OpsWorks must be running Chef Automate 2.0.
- A Chef SaaS environment must be configured. Refer to the [Getting Started with Chef SaaS](/saas/get_started/) page.
- Restoration is performed on AWS OpsWorks for Chef SaaS.
- Splay mode and baseline are up to two client runs an hour. Refer to the [Chef Infra Client](/ctl_chef_client/) page for more details on configuring splay mode in the `client.rb` file.
- There must be one compliance scan per hour.

## Redirect the nodes to Chef SaaS

Progress Chef developed a Cookbook that can run against all nodes under management in the AWS OpsWorks environment. This Cookbook redirects all nodes to the new Chef SaaS instance.

To redirect nodes from AWS OpsWorks to Chef SaaS:

1. Create a [new cookbook](/cookbooks/#generate-a-cookbook).
1. Update the [Policyfile](/config_rb_policyfile/) with the following content:

    ```ruby
    # Policyfile.rb  Describe how you want Chef Infra Client to build your system.
    #
    # For more information on the Policyfile feature, visit https://docs.chef.io/policyfile

    # A name that describes the system you are building with Chef docs.
    name 'your_client'

    # Where to find external cookbooks:
    default_source :supermarket

    # run_list: chef_client runs the recipes in the order specified.
    run_list 'your_client::default'

    # Specify a custom source for a single cookbook:
    cookbook 'your_client', path: '.'
    ```

1. Add attributes for the new and old server:

    `default['your_client']['chef_server_old'] = '<OLD_CHEF_SERVER_URL>'`

    `default['your_client']['chef_server_new'] = '<NEW_CHEF_SERVER_URL>'`

1. Upload the new cookbook to your server on AWS OpsWorks.
1. Log in to Chef SaaS after the next Infra Client run to verify that the nodes have redirected to Chef SaaS.

Contact your SA if you need help.
