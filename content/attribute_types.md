+++
title = "Attribute Types"
draft = false
aliases = ["/essentials_cookbook_attribute_files_attribute_automatic"]
gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Attribute Types"
    identifier = "chef_infra/cookbook_reference/attributes/attributes_types.md Attributes"
    parent = "chef_infra/cookbook_reference/attributes"
+++

Chef Infra Client uses six types of attributes to determine the value that is applied to a node during a Chef Infra Client run.
In addition, Chef Infra Client gathers attribute values from up to five locations.
The combination of attribute types and sources makes up to 15 different competing values available during a Chef Infra Client run.

The attribute types are:

`default`
: {{< readfile file="content/reusable/md/node_attribute_type_default.md" >}}

`force_default`
: Use the force_default attribute to ensure that an attribute defined in a cookbook (by an attribute file or by a recipe) takes precedence over a default attribute set by a role or an environment.

`normal`
: {{< readfile file="content/reusable/md/node_attribute_type_normal.md" >}}

`override`
: {{< readfile file="content/reusable/md/node_attribute_type_override.md" >}}

`force_override`
: Use the force_override attribute to ensure that an attribute defined in a cookbook (by an attribute file or by a recipe) takes precedence over an override attribute set by a role or an environment.

`automatic`
: {{< readfile file="content/reusable/md/node_attribute_type_automatic.md" >}}

