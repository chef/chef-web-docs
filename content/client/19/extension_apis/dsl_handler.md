+++
title = "About the Handler DSL"
draft = false

[menu]
  [menu.extension_apis]
    title = "Handler DSL"
    identifier = "extension_apis/handlers/dsl_handler.md Handler DSL"
    parent = "extension_apis/handlers"
    weight = 20
+++

{{< readfile file="content/reusable/md/dsl_handler_summary.md" >}}

## on Method

{{< readfile file="content/reusable/md/dsl_handler_method_on.md" >}}

## Event Types

{{< readfile file="content/reusable/md/dsl_handler_event_types.md" >}}

## Examples

The following examples show ways to use the Handler DSL.

### Send Email

{{< readfile file="content/reusable/md/dsl_handler_slide_send_email.md" >}}

#### Define How Email is Sent

{{< readfile file="content/reusable/md/dsl_handler_slide_send_email_library.md" >}}

#### Add the Handler

{{< readfile file="content/reusable/md/dsl_handler_slide_send_email_handler.md" >}}

#### Test the Handler

{{< readfile file="content/reusable/md/dsl_handler_slide_send_email_test.md" >}}

### etcd Locks

{{< readfile file="content/reusable/md/dsl_handler_example_etcd_lock.md" >}}

### HipChat Notifications

{{< readfile file="content/reusable/md/dsl_handler_example_hipchat.md" >}}

### `attribute_changed` event hook

In a cookbook library file, you can add this to print out all
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
