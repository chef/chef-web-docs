+++
title = "Custom Resources Notes"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/custom_resources_notes.html"]

[menu]
  [menu.infra]
    title = "Custom Resource Guide"
    identifier = "chef_infra/cookbook_reference/resources/custom_resources_notes.md Custom Resource Guide"
    parent = "chef_infra/cookbook_reference/resources"
    weight = 50
+++

{{< warning >}}

This page mentions multiple ways of building custom resources. Chef
Software recommends you try the approach outlined in the [Custom
Resource documentation](/custom_resources/) first, before trying the
resource/provider pair (older approach) or library type (pure Ruby)
approaches. If you run into issues while designing 12.5-style custom
resources, please ask for help in the [Chef Mailing
List](https://discourse.chef.io) or [file a
bug](https://github.com/chef/chef/issues/new) for Chef Infra Client.

{{< /warning >}}

## Custom Resources

This is the recommended way of writing resources for all users. There
are two gotchas which we're working through:

1. For helper functions that you used to write in your provider code or
    used to mixin to your provider code, you have to use an
    `action_class.class_eval do ... end` block.

You cannot subclass, and must use mixins for code-sharing (which is
really a best practice anyway -- e.g. see languages like rust which do
not support subclassing).

in `resources/whatever.rb`:

```ruby
resource_name :my_resource
provides :my_resource

property :foo, String, name_property: true
extend MyResourceHelperFunctions # probably only used for common properties which is why you extend with class methods

action :run do
  # helpers used in actions must be defined or included in the action_class block
  a_helper()

  # Always use new_resource to refer to your resource property
  # This make sure you are reading from the correct scope
  puts new_resource.foo
end

action_class do
  include MyProviderHelperFunctions

  def a_helper
  end
end
```
