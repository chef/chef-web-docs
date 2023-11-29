+++
title = "About Cookbooks"
draft = false

gh_repo = "chef-web-docs"

aliases = ["/cookbooks.html", "/essentials_cookbooks.html"]
product = ["client", "server", "workstation"]

[menu]
  [menu.infra]
    title = "About Cookbooks"
    identifier = "chef_infra/cookbook_reference/cookbooks.md About Cookbooks"
    parent = "chef_infra/cookbook_reference"
    weight = 10
+++

{{< readfile file="content/reusable/md/cookbooks_summary.md" >}}

{{< readfile file="content/reusable/md/infra_lang_ruby.md" >}}

{{< readfile file="content/reusable/md/infra_lang_summary.md" >}}

Chef Infra Client runs a recipe only when instructed. When Chef Infra Client runs the same recipe more than once, the results will be the same system state each time. When a recipe is run against a system, but nothing has changed on either the system or in the recipe, Chef Infra Client will not change anything.

## Components

A cookbook is comprised of recipes and other optional components as files or directories.

| Component                              | File/Directory Name | Description                                                                                                                                                  |
|----------------------------------------|---------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Recipes](/recipes/)                   | recipes/            | {{< readfile file="content/reusable/md/cookbooks_recipe.md" >}}                                                                                              |
| [Attributes](/attributes/)             | attributes/         | {{< readfile file="content/reusable/md/cookbooks_attribute.md" >}}                                                                                           |
| [Files](/files/)                       | files/              | A file distribution is a specific type of resource that tells a cookbook how to distribute files, including by node, by platform, or by file version.        |
| [Libraries](/libraries/)               | libraries/          | A library allows the use of arbitrary Ruby code in a cookbook, either as a way to extend the Chef Infra Client language or to implement a new class.         |
| [Custom Resources](/custom_resources/) | resources/          | A custom resource is an abstract approach for defining a set of actions and (for each action) a set of properties and validation parameters.                 |
| [Templates](/templates/)               | templates/          | A template is a file written in markup language that uses Ruby statements to solve complex configuration scenarios.                                          |
| [Ohai Plugins](/ohai_custom/)          | ohai/               | Custom Ohai plugins can be written to load additional information about your nodes to be used in recipes. This requires Chef Infra Server 12.18.14 or later. |
| [Metadata](/config_rb_metadata/)       | metadata.rb         | This file contains information about the cookbook such as the cookbook name, description, and version.                                                       |

## Community Cookbooks

Chef maintains a large collection of cookbooks. In addition, there are thousands of cookbooks created and maintained by the community:

|                                   Components                                   |                                                                               Description                                                                               |
|:------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| [Cookbooks Maintained by Chef](https://github.com/chef-cookbooks)              | Chef maintains a collection of cookbooks that are widely used by the community.                                                                                         |
| [Cookbooks Maintained by Sous Chefs](https://github.com/sous-chefs)            | Sous Chefs is a community organization that collaborates to maintain many of the most used Chef cookbooks.                                                              |
| [Cookbooks Maintained by the Community](https://supermarket.chef.io/cookbooks) | The community has authored thousands of cookbooks, ranging from niche cookbooks that are used by only a few organizations to popular cookbooks used by almost everyone. |

## Generate a Cookbook

Use the [chef generate cookbook subcommand](/workstation/ctl_chef/#chef-generate-cookbook) to generate a cookbook.

A cookbook generated with`chef generate cookbook custom_web` creates a cookbook named `custom_web` with the directory structure:

```text
. cookbooks
└── custom_web
    ├── CHANGELOG.md
    ├── LICENSE
    ├── Policyfile.rb
    ├── README.md
    ├── chefignore
    ├── compliance
    │   ├── README.md
    │   ├── inputs
    │   ├── profiles
    │   └── waivers
    ├── kitchen.yml
    ├── metadata.rb
    ├── recipes
    │   └── default.rb
    └── test
        └── integration
            └── default
                └── default_test.rb
```
