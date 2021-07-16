The default action in a custom resource is, by default, the first action
listed in the custom resource. For example, action `aaaaa` is the
default resource:

```ruby
property :property_name, RubyType, default: 'value'

...

action :aaaaa do
 # the first action listed in the custom resource
end

action :bbbbb do
 # the second action listed in the custom resource
end
```

The `default_action` method may also be used to specify the default
action. For example:

```ruby
property :property_name, RubyType, default: 'value'

# Define bbbbb aas the default action
default_action :bbbbb

action :aaaaa do
 # the first action listed in the custom resource
end

action :bbbbb do
 # the second action listed in the custom resource
end
```
