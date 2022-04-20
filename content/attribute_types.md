+++
title = "Attribute Types"
draft = false
aliases = ["/essentials_cookbook_attribute_files_attribute_automatic"]
gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Attribute Types"
    identifier = "chef_infra/cookbook_reference/attributes/attributes_types.md Attributes"
    parent = "chef_infra/cookbook_reference/attributes"
+++

Chef Infra Client uses six types of attributes to determine the value
that is applied to a node during a Chef Infra Client run. In addition,
Chef Infra Client gathers attribute values from up to five locations.
The combination of attribute types and sources makes up to 15 different
competing values available during a Chef Infra Client run:

</br>
<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Attribute Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>default</code></td>
<td>{{< readFile_shortcode file_path="layouts/shortcodes/node_attribute_type_default.md" >}}</td>
</tr>
<tr>
<td><code>force_default</code></td>
<td>{{< readFile_shortcode file_path="layouts/shortcodes/node_attribute_type_force_default.md" >}}</td>
</tr>
<tr>
<td><code>normal</code></td>
<td>{{< readFile_shortcode file_path="layouts/shortcodes/node_attribute_type_normal.md" >}}</td>
</tr>
<tr>
<td><code>override</code></td>
<td>{{< readFile_shortcode file_path="layouts/shortcodes/node_attribute_type_override.md" >}}</td>
</tr>
<tr>
<td><code>force_override</code></td>
<td>{{< readFile_shortcode file_path="layouts/shortcodes/node_attribute_type_force_override.md" >}}</td>
</tr>
<tr>
<td><code>automatic</code></td>
<td>{{< readFile_shortcode file_path="layouts/shortcodes/node_attribute_type_automatic.md" >}}</td>
</tr>
</tbody>
</table>
