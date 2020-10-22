The following example shows how to use the `not_if` condition to create
a file based on a template and using a string to specify the condition:

```ruby
template '/etc/some_config' do
  mode '0640'
  source 'some_config.erb'
  not_if 'some_app --check-config'
end
```
