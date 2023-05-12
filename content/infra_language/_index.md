+++
title = "About the Chef Infra Language"
draft = false
gh_repo = "chef-web-docs"

aliases = ["/dsl_recipe.html", "/dsl_recipe"]

[cascade]
  product = ["client"]

[menu]
  [menu.infra]
    title = "Language Overview"
    identifier = "chef_infra/infra_language/ Language Overview"
    parent = "chef_infra/infra_language"
    weight = 10
+++

{{< readfile file="content/reusable/md/infra_lang_summary.md" >}}

{{< readfile file="content/reusable/md/infra_lang_ruby.md" >}}

## Resources

Resources are the cornerstone of the Chef Infra Language. Resources define the desired state of an object on a system. A resource can be as simple as a directory or as complex or a complete security policy. Chef Infra Client ships with over 150 resources for configuring components such as packages, files, directories, or firewalls. For more information on resources in Chef Infra Client including a complete list of those included out of the box see [Resources](/resources).

## Helpers Methods

The Chef Infra Language provides support for using attributes, data bags (and
encrypted data), and search results in a recipe, as well as four helper
methods that can be used to check for a node's platform from the recipe
to ensure that specific actions are taken for specific platforms.
