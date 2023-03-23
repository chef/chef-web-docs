+++
title = "DeprecatedChefSpecPlatform"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `DeprecatedChefSpecPlatform`

The full name of the cop is: `Chef/Deprecations/DeprecatedChefSpecPlatform`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Use currently supported platforms in ChefSpec listed at https://github.com/chefspec/fauxhai/blob/main/PLATFORMS.md. Fauxhai / ChefSpec will perform fuzzy matching on platform version values so it's always best to be less specific ie. 10 instead of 10.3

## Examples


let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') }
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
<td style="text-align:center">5.20.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/spec/**/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
