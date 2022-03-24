The following example shows how to use the `only_if` condition to create
a file based on a template and using a string to specify the condition:

```ruby
template '/tmp/somefile' do
  mode '0755'
  source 'somefile.erb'
  only_if 'test -f /etc/passwd'
end
```
