+++
title = "Definitions"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `Definitions`

The full name of the cop is: `Chef/Modernize/Definitions`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

In 2016 with Chef Infra Client 12.5 Custom Resources were introduced as a way of writing reusable resource code that could be shipped in cookbooks. Custom Resources offer many advantages of legacy Definitions including unit testing with ChefSpec, input validation, actions, common properties like not_if/only_if, and resource reporting.

## Examples

<nil>

## Configurable attributes

<table>
<tbody><tr>
<th>Name</th>
<th>Default value</th>
<th>Configurable values</th>
</tr>
<tr>
<td style="text-align:center">Version Added</td>
<td style="text-align:center">5.11.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/definitions/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
