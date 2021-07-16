The `converge_if_changed` method may be used multiple times. The
following example shows how to use the `converge_if_changed` method to
compare the multiple desired property values against the current
property values (as loaded by the `load_current_value` method).

```ruby
property :path, String
property :content, String
property :mode, String

# Load the current value for content and mode
load_current_value do |new_resource|
  if ::File.exist?(new_resource.path)
    content IO.read(new_resource.path)
    mode ::File.stat(new_resource.path).mode
  end
end

action :create do

  # If the value of content has changed
  # write file
  converge_if_changed :content do
    IO.write(new_resource.path, new_resource.content)
  end

  # If the value of mode has changed then
  # chmod file
  converge_if_changed :mode do
    ::File.chmod(new_resource.mode, new_resource.path)
  end
end
```

where

- `load_current_value` loads the property values for both `content`
    and `mode`
- A `converge_if_changed` block tests only `content`
- A `converge_if_changed` block tests only `mode`

Chef Infra Client will only update the property values that require
updates and will not make changes when the property values are already
in the desired state.
