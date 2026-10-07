+++
title = "Chef/Correctness/PlatformVersionStringComparison"
aliases = ["/workstation/cookstyle/chef_correctness_platformversionstringcomparison/"]

[menu]
  [menu.workstation]
    title = "PlatformVersionStringComparison"
    identifier = "chef_workstation/cookstyle/cops/Chef/Correctness/PlatformVersionStringComparison"
    parent = "chef_workstation/cookstyle/cops/Chef/Correctness"
+++

<!-- vale off -->
<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Correctness`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Ohai reports version attributes as strings, so comparing one with `<`, `>`, `<=`, or `>=`
compares them character by character rather than as versions. That gives the wrong answer
whenever the version numbers have different digit counts:

  '7.9' >= '10'   # => true, because '7' sorts after '1'
  '9' > '10'      # => true

Compare the major version as an integer with `node['platform_version'].to_i`, or compare
full versions with `Gem::Version`.

## Examples

```ruby
# bad
node['platform_version'] >= '10'
node['platform_version'] < '7.4'

# good
node['platform_version'].to_i >= 10
Gem::Version.new(node['platform_version']) >= Gem::Version.new('7.4')

# good - equality is a plain string match, which is fine
node['platform_version'] == '10'
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
<td style="text-align:center">9.0.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
