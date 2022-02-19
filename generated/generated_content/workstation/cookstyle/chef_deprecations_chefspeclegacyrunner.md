+++
title = "ChefSpecLegacyRunner"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ChefSpecLegacyRunner`

The full name of the cop is: `Chef/Deprecations/ChefSpecLegacyRunner`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

## Examples


#### incorrect

```ruby

describe 'foo::default' do
  subject { ChefSpec::Runner.new.converge(described_recipe) }

  # some spec code
end
```

#### correct

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
