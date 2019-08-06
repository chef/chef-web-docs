+++
title = "Manage Secrets"
description = "DESCRIPTION"
draft = false

aliases = "/secrets.html"

[menu]
  [menu.docs]
    title = "Secrets"
    identifier = "chef_infra/concepts/secrets.html Secrets"
    parent = "chef_infra/concepts"
    weight = 100
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/secrets.rst)

One way to manage secrets used by Chef is with data bags.

Data Bags
=========

{{% data_bag %}}

Create a Data Bag
-----------------

{{% data_bag_create %}}

### Using Knife

{{% data_bag_create_knife %}}

### Manually

{{% data_bag_create_manual %}}

Store Data in a Data Bag
------------------------

{{% data_bag_store %}}

### Directory Structure

{{% data_bag_directory_structure %}}

### Data Bag Items

{{% data_bag_item %}}

Encrypt a Data Bag Item
-----------------------

{{% data_bag_encryption %}}

### Encryption Versions

{{% data_bag_encryption_versions %}}

### Knife Options

{{% data_bag_encryption_knife_options %}}

### Secret Keys

{{% data_bag_encryption_secret_key %}}

### Encrypt

{{% data_bag_encryption_encrypt %}}

### Verify Encryption

{{% data_bag_encryption_verify %}}

### Decrypt

{{% data_bag_encryption_decrypt %}}

Edit a Data Bag Item
--------------------

{{% data_bag_edit %}}

### Using Knife

{{% knife_data_bag_edit %}}

{{% knife_data_bag_edit_item %}}

### Using Chef Manage

{{% manage_webui_policy_data_bag_edit_item %}}

Use Data Bags
-------------

Data bags can be accessed in the following ways:

### with Search

{{% data_bag_search %}}

### with Environments

{{% data_bag_environments %}}

### with Recipes

{{% data_bag_recipes %}}

#### Load with Recipe DSL

{{% data_bag_recipes_load_using_recipe_dsl %}}

#### Create and edit

{{% data_bag_recipes_edit_within_recipe %}}

#### Create users

{{% data_bag_recipes_create_users %}}

### with chef-solo

{{% data_bag_chef_solo %}}
