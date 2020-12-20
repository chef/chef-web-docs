+++
title = "About the Handler DSL"
draft = false

gh_repo = "chef-web-docs"

aliases = ["/dsl_handler.html"]

[menu]
  [menu.infra]
    title = "Handler DSL"
    identifier = "chef_infra/extension_apis/handlers/dsl_handler.md Handler DSL"
    parent = "chef_infra/extension_apis/handlers"
    weight = 20
+++

{{% dsl_handler_summary %}}

## on Method

{{% dsl_handler_method_on %}}

## Event Types

{{% dsl_handler_event_types %}}

## Examples

The following examples show ways to use the Handler DSL.

### Send Email

{{% dsl_handler_slide_send_email %}}

#### Define How Email is Sent

{{< readFile_shortcode file="dsl_handler_slide_send_email_library.md" >}}

#### Add the Handler

{{% dsl_handler_slide_send_email_handler %}}

#### Test the Handler

{{% dsl_handler_slide_send_email_test %}}

### etcd Locks

{{% dsl_handler_example_etcd_lock %}}

### HipChat Notifications

{{% dsl_handler_example_hipchat %}}

### `attribute_changed` event hook

In a cookbook library file, you can add this in order to print out all
attribute changes in cookbooks:

```ruby
Chef.event_handler do
  on :attribute_changed do |precedence, key, value|
    puts "setting attribute #{precedence}#{key.map { |n| "[\"#{n}\"]" }.join} = #{value}"
  end
end
```

If you want to setup a policy that override attributes should never be
used:

```ruby
Chef.event_handler do
  on :attribute_changed do |precedence, key, value|
    raise 'override policy violation' if precedence == :override
  end
end
```
