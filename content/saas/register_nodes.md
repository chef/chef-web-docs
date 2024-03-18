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

Once everything has been set up and restored to the new Chef environment, the nodes under management must be redirected from AWS OpsWorks to Chef SaaS. This guide will provide recommendations on how this can be accomplished.

## Prerequisites

1. Running Automate 2.0 in AWS OpsWorks.

1. A Chef SaaS Environment. Refer to the [Getting Started](/get_started/) with Chef SaaS page.

1. Restoration performed of AWS OpsWorks to Chef SaaS.

1. Splay mode and baseline are up to 2 client runs an hour. Refer to the [Chef Infra Client](https://docs.chef.io/ctl_chef_client/) page for more details on how to configure splay mode in client.rb file.

1. 1 compliance scans an hour.

## Obtain example Cookbook/Recipe to point nodes to new Chef SaaS instance

Progress Chef has developed a Cookbook and Recipe that can run against all nodes under management in the AWS OpsWorks environment. This Cookbook will redirect all nodes to the new Chef SaaS instance. Some sample images of the cookbooks, PolicyFile.rb, attribute file and recipe file are shown below:

* Cookbook:

IMAGE

* PolicyFile.rb

IMAGE

* Attribute

IMAGE

`default[‘your_client']['chef_server_old'] = ‘<Old chef-server URL>’ `

`default[‘your_client']['chef_server_new'] = ‘<New chef-server URL>`

* Recipe

IMAGE
