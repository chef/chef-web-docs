+++
title = "Delivery"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `Delivery`

The full name of the cop is: `Chef/Deprecations/Delivery`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

The Delivery CLI from Chef Delivery/Workflow is no longer bundled with Chef Workstation as Chef Delivery is end of life as of Dec 31st 2021.

Users of Delivery / Workflow would include a `.delivery` directory in their cookbooks. This directory would include Delivery local-mode configs
or Delivery cookbooks. The contents of this directory are now obsolete and should be removed.

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
<td style="text-align:center">7.31.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/.delivery/project.toml</code></li>
<li><code>**/.delivery/config.json</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
