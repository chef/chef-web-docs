The following example shows how read/write/execute permissions can be
set using a variable named `user_home`, and then for owners and groups
on any matching node:

``` ruby
user_home = "/#{node[:matching_node][:user]}"

directory user_home do
  owner 'node[:matching_node][:user]'
  group 'node[:matching_node][:group]'
  mode '0755'
  action :create
end
```

where `matching_node` represents a type of node. For example, if the
`user_home` variable specified `{node[:nginx]...}`, a recipe might look
similar to:

``` ruby
user_home = "/#{node[:nginx][:user]}"

directory user_home do
  owner 'node[:nginx][:user]'
  group 'node[:nginx][:group]'
  mode '0755'
  action :create
end
```