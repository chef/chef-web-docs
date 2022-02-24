+++
title = "DependsOnKernelModuleCookbook"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `DependsOnKernelModuleCookbook`

The full name of the cop is: `Chef/Modernize/DependsOnKernelModuleCookbook`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 14.3+ |

Don't depend on the kernel_module cookbook made obsolete by Chef Infra Client 14.3. The kernel_module resource is now included in Chef Infra Client itself.

## Examples


#### incorrect

```ruby
depends 'kernel_module'
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
<td style="text-align:center">7.19.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/metadata.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
