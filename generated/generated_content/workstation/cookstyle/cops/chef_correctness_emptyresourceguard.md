+++
title = "Chef/Correctness/EmptyResourceGuard"
aliases = ["/workstation/cookstyle/chef_correctness_emptyresourceguar/"]

+++

<!-- vale off -->
<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Correctness`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Resource guards (not_if/only_if) should not be empty strings as empty strings will always evaluate to true.
This will cause confusion in your cookbooks as the guard will always pass.

Empty strings in Ruby are "truthy", which means:
- `only_if ''` will ALWAYS execute the resource (guard always passes)
- `not_if ''` will NEVER execute the resource (guard always blocks)

This behavior is usually unintended and can lead to resources running when they shouldn't
or never running when they should.

## Examples

```ruby
# bad
template '/etc/foo' do
  mode '0644'
  source 'foo.erb'
  only_if ''  # This will always be true - resource always executes
end

cookbook_file '/logs/foo/error.log' do
  source 'error.log'
  not_if { '' }  # This will always be true - resource never executes
end

service 'apache2' do
  action :restart
  only_if { '' }  # Block form also problematic
end

# good
template '/etc/foo' do
  mode '0644'
  source 'foo.erb'
  only_if 'test -f /etc/foo'  # Actual shell command
end

cookbook_file '/logs/foo/error.log' do
  source 'error.log'
  not_if { ::File.exist?('/logs/foo/error.log') }  # Proper Ruby expression
end

service 'apache2' do
  action :restart
  only_if { node['platform'] == 'ubuntu' }  # Meaningful condition
end

# Or simply remove the guard if no condition is needed
package 'curl' do
  action :install
end
```

## Configurable attributes

<table>
<tbody><tr>
<th>Name</th>
<th>Default value</th>
<th>Configurable values</th>
</tr>
<tr>
<td style="text-align:center">Version Added</td>
<td style="text-align:center">8.4.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
