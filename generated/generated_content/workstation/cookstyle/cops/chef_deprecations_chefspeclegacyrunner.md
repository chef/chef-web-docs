+++
title = "Chef/Deprecations/ChefSpecLegacyRunner"
aliases = ["/workstation/cookstyle/chef_deprecations_chefspeclegacyrunner/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Use `ChefSpec::SoloRunner` or `ChefSpec::ServerRunner` instead of the deprecated `ChefSpec::Runner`. These new runners were introduced in ChefSpec 4.1 (Oct 2014).

## Examples

### incorrect

```ruby

describe 'foo::default' do
  subject { ChefSpec::Runner.new.converge(described_recipe) }

  # some spec code
end
```

### correct

```ruby

describe 'foo::default' do
  subject { ChefSpec::ServerRunner.new.converge(described_recipe) }

  # some spec code
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
<td style="text-align:center">5.8.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/spec/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
