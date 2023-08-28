+++
title = "Chef/Deprecations/Cheffile"
aliases = ["/workstation/cookstyle/chef_deprecations_cheffile/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

The Librarian-Chef depsolving project is no longer maintained and a Cheffile should not be used for cookbook depsolving. Consider using Policyfiles instead. If the Policyfiles model is not compatible with your workflow you may find Berkshelf offers a more similar, and still supported, experience to Librarian-Chef.

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
<td style="text-align:center">5.12.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/Cheffile</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
