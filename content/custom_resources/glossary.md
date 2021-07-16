+++
title = "Glossary Custom Resources"
draft = false
gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "About Custom Resources"
    identifier = "chef_infra/cookbook_reference/custom_resources/glossaary Custom Resources Glossary"
    parent = "chef_infra/cookbook_reference/custom_resources"
    weight = 20
+++


## Chef Infra Client Custom Resources Glossary

This glossary describes methods that are available when writing a Custom Resource.

The following __Domain Specific Language (DSL)__ methods are available when writing Custom Resources.

## action_class

{{ partial dsl/action_class.md . }}

## converge_if_changed

{{ partial dsl/converge_if_changed . }}

## Multiple Properties

{{ partial dsl/converge_if_changed_multiple . }}

## default_action

{{ partial dsl_default_action . }}

## load_current_value

{{ partial dsl_load_current_value . }}

## new_resource.property

{{ partial dsl/new_resource . }}

## property

{{ partial dsl/property . }}

## ruby_type

{{ partial dsl/property_ruby_type . }}

## sensitive

{{ partial dsl/sensitive . }}

## validators

{{ partial dsl/property_validation_parameter . }}

## desired_state

{{ partial dsl/property_desired_state . }}

## identity

{{ partial dsl/property_identity . }}

## Block Arguments

{{ partial dsl/property_block_argument . }}

## property_is_set?

{{ partial dsl/property_is_set . }}

## provides

{{ partial dsl/provides . }}

## reset_property

{{ partial dsl/reset_property . }}

## coerce

{{ partial dsl/coerce . }}

## resource_name

{{< note >}}

{{% ruby_style_patterns_hyphens %}}

{{< /note >}}

{{ partial dsl_custom_resource_method_resource_name }}

{{ partial dsl_custom_resource_method_resource_name_example . }}

## deprecated

{{ partial dsl_custom_resource_method_deprecated  . }}

## unified_mode
