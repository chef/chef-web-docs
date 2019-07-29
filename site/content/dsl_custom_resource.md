+++
title = "About the Custom Resource DSL"
description = "DESCRIPTION"
draft = false

aliases = "/dsl_custom_resource.html"

[menu]
  [menu.docs]
    title = "Custom Resources DSL"
    identifier = "custom resources dsl/dsl_custom_resource.html"
    parent = "chef infra/cookbook reference"
    weight = 70
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/dsl_custom_resource.rst)

Use the Custom Resource DSL to define property behaviors within custom
resources, such as:

-   Loading the value of a specific property
-   Comparing the current property value against a desired property
    value
-   Telling Chef Infra Client when and how to make changes

action_class
=============

{{% dsl_custom_resource_method_converge_if_changed_multiple %}}

converge_if_changed
=====================

{{% dsl_custom_resource_method_converge_if_changed %}}

Multiple Properties
-------------------

{{% dsl_custom_resource_method_converge_if_changed_multiple %}}

default_action
===============

{{% dsl_custom_resource_method_default_action %}}

load_current_value
====================

{{% dsl_custom_resource_method_load_current_value %}}

new_resource.property
======================

{{% dsl_custom_resource_method_new_resource %}}

property
========

{{% dsl_custom_resource_method_property %}}

ruby_type
----------

{{% dsl_custom_resource_method_property_ruby_type %}}

validators
----------

{{% dsl_custom_resource_method_property_validation_parameter %}}

desired_state
--------------

{{% dsl_custom_resource_method_property_desired_state %}}

identity
--------

{{% dsl_custom_resource_method_property_identity %}}

Block Arguments
===============

{{% dsl_custom_resource_method_property_block_argument %}}

property_is_set?
==================

{{% dsl_custom_resource_method_property_is_set %}}

provides
========

{{% dsl_custom_resource_method_provides %}}

override
--------

{{% dsl_custom_resource_method_provides_override %}}

reset_property
===============

{{% dsl_custom_resource_method_reset_property %}}

resource_name
==============

<div class="note" markdown="1">

<div class="admonition-title" markdown="1">

Note

</div>

{{% ruby_style_patterns_hyphens %}}

</div>

{{% dsl_custom_resource_method_resource_name %}}

{{% dsl_custom_resource_method_resource_name_example %}}
