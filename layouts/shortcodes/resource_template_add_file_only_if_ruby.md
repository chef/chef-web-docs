The following example shows how to use the `only_if` condition to create
a file based on a template, and then use Ruby to specify a condition:

```ruby
template '/etc/some_app/some_config' do
  mode '0640'
  source 'some_config.erb'
  only_if { ::File.exist?('/etc/some_app/') }
end
```
