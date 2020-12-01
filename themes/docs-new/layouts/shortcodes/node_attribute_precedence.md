Chef Infra Client applies attributes in the following
order:

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
  <tr>
    <th>Attribute</th>
    <th>Order Applied</th>
  </tr>
</thead>
<tbody>
  <tr class="odd">
    <td><code>`default`</code></td>
    <td>1. Cookbook<br>2. Recipe<br>3. Environment<br>4. Role</td>
  </tr>
  <tr class="even">
    <td><code>`force_default`</code></td>
    <td>1. Cookbook attribute file<br>2. Recipe</td>
  </tr>
  <tr class="odd">
    <td><code>`normal`</code></td>
    <td>1. JSON file passed with <code>`chef-client -j`</code><br>2. Recipe</td>
  </tr>
  <tr class="even">
    <td><code>`override`</code></td>
    <td>1. Cookbook attribute file<br>2. Recipe<br>3. Role<br>4. Environment</td>
  </tr>
  <tr class="odd">
    <td><code>`force_override`</code></td>
    <td>1. Cookbook attribute file<br>2. Recipe</td>
  </tr>
  <tr class="even">
    <td><code>`automatic`</code></td>
    <td>1. Identified by Ohai at the start of a Chef Infra Client Run</td>
  </tr>
</tbody>
</table>

<div class="admonition-note">

<p class="admonition-note-title">Note</p>

<div class="admonition-note-text">

The attribute precedence order for roles and environments is reversed
for `default` and `override` attributes. The precedence order for
`default` attributes is environment, then role. The precedence order for
`override` attributes is role, then environment. Applying environment
`override` attributes after role `override` attributes allows the same
role to be used across multiple environments, yet ensuring that values
can be set that are specific to each environment (when required). For
example, the role for an application server may exist in all
environments, yet one environment may use a database server that is
different from other environments.



</div>

</div>

Attribute precedence, viewed from the same perspective as the overview
diagram, where the numbers in the diagram match the order of attribute
precedence:

![image](/images/overview_chef_attributes_precedence.png)

Attribute precedence, when viewed as a table:

![image](/images/overview_chef_attributes_table.png)
