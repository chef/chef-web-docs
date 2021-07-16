`action_class` makes methods available to all actions within a custom resource.

## Example

You have a template that requires 'yes' or 'no' written as a String, but you would like the user to use true or false for convenience. To allow both the add and remove actions to have access to this method, place the method inthe action_class block.

```ruby
property :example, [true, false], default: true

action :add do

  choco_value = bool_to_string(new_resource.example)

  template "file.conf" do
    source 'file.conf.erb'
    variables(chocolate: choco_value)
    action :create
  end
end

action :remove do

  choco_value = bool_to_string(new_resource.example)

  template "file.conf" do
    source 'file.conf.erb'
    variables(chocolate: choco_value)
    action :delete
  end
end

action_class do
  def bool_to_string(s)
    s ? 'yes' : 'false'
  end
end
```
