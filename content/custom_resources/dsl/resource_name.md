## Introduced

Chef Infra Client <!--  TODO: -->

Use the `resource_name` method at the top of a custom resource to
declare a custom name for that resource. For example:

```ruby
resource_name :my_resource_name
```

The `resource_name` is only used as a fallback name for display purposes.
Even for display purposes, the name used in recipe code which matches a
`provides` statement is favored over the `resource_name` setting, so the
`resource_name` has little effect. In Chef Infra Client 16 and later,
the first `provides` in a resource declaration also sets the fallback
`resource_name`, so we do not recommend that users set the `resource_name` at all.
The `resource_name` setting is necessary for backwards compatibility with Chef
Infra Client 12 through 15.

## Example

For example, the `httpd.rb` file in the `website` cookbook could be
assigned a custom resource name like this:

```ruby
resource_name :httpd

property :homepage, String, default: '<h1>Hello world!</h1>'

action :create do
  package 'httpd'

  service 'httpd' do
    action [:enable, :start]
  end

  file '/var/www/html/index.html' do
    content new_resource.homepage
  end
end
```

and is then usable in a recipe like this:

```ruby
httpd 'build website' do
  homepage '<h1>Welcome to the Example Co. website!</h1>'
  action :create
end
```
