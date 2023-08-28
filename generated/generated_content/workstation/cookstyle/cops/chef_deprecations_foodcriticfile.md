+++
title = "Chef/Deprecations/FoodcriticFile"
aliases = ["/workstation/cookstyle/chef_deprecations_foodcriticfile/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

The Foodcritic cookbook linter has been deprecated and should no longer be used for validating cookbooks. Do not include the `.foodcritic` config file used by Foodcritic in your cookbooks.

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
<td style="text-align:center">7.32.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/.foodcritic</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
