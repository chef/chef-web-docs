Chef Infra Client applies attributes in the following
order:

<table>
<colgroup>
<col style="width: 15%" />
<col style="width: 20%" />
<col style="width: 30%" />

</colgroup>
<thead>
  <tr>
    <th>Application Order (Last One Wins)</th>
    <th>Attribute Type</th>
    <th>Source Order</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>1</td>
    <td><code>`default`</code></td>
    <td>Cookbook attribute file<br>Recipe<br>Environment<br>Role</td>
  </tr>
  <tr>
    <td>2</td>
    <td><code>`force_default`</code></td>
    <td>Cookbook attribute file<br>Recipe</td>
  </tr>
  <tr>
    <td>3</td>
    <td><code>`normal`</code></td>
    <td>JSON file passed with <code>`chef-client -j`</code><br>Cookbook attribute file<br>Recipe</td>
  </tr>
  <tr>
    <td>4</td>
    <td><code>`override`</code></td>
    <td>Cookbook attribute file<br>Recipe<br>Role<br>Environment</td>
  </tr>
  <tr>
    <td>5</td>
    <td><code>`force_override`</code></td>
    <td>Cookbook attribute file<br>Recipe</td>
  </tr>
  <tr>
    <td>6</td>
    <td><code>`automatic`</code></td>
    <td>Identified by Ohai at the start of a Chef Infra Client Run</td>
  </tr>
</tbody>
</table>

<div class="admonition-note">

<p class="admonition-note-title">Note</p>

<div class="admonition-note-text">

The attribute precedence order for the sources "roles" and "environments" are opposite in the `default` and `override`. The `default` order is **environment** then **role**. The `override` order is **role** then **environment**

Applying the role `override` first lets you use the same role in a set of environments.
Applying the environment `override` on top of the role `override` lets you define a subset of these with environment-specific settings.

This is useful if you have an environment that is different within a sub-set of a role. For example, the role for an application server may exist in all environments, but one environment may use a different database server.
</div>

</div>

Attribute precedence, viewed from the same perspective as the overview
diagram, where the numbers in the diagram match the order of attribute
precedence:

![image](/images/overview_chef_attributes_precedence.png)

Attribute precedence, when viewed as a table:

![image](/images/overview_chef_attributes_table.png)
