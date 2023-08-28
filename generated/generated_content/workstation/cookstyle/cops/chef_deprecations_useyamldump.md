+++
title = "Chef/Deprecations/UseYamlDump"
aliases = ["/workstation/cookstyle/chef_deprecations_useyamldump/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Chef Infra Client 16.5 introduced performance enhancements to Ruby library loading. Due to the underlying implementation of Ruby's `.to_yaml` method, it does not automatically load the `yaml` library and `YAML.dump()` should be used instead to properly load the `yaml` library.

## Examples

### incorrect

```ruby
{"foo" => "bar"}.to_yaml
```

### correct

```ruby
YAML.dump({"foo" => "bar"})
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
<td style="text-align:center">6.21.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
