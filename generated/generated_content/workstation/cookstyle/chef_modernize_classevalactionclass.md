+++
title = "ClassEvalActionClass"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ClassEvalActionClass`

The full name of the cop is: `Chef/Modernize/ClassEvalActionClass`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 12.9+ |

In Chef Infra Client 12.9 and later it is no longer necessary to call the class_eval method on the action class block.

## Examples


#### incorrect

```ruby
action_class.class_eval do
  foo
end
```

#### correct

```ruby
action_class do
  foo
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
<td style="text-align:center">7.23.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/resources/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
