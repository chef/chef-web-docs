+++
title = "IncludeResourceExamples"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `IncludeResourceExamples`

The full name of the cop is: `Chef/Sharing/IncludeResourceExamples`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Not Enabled | No | 13.9+ |

## Examples

```

#### correct

```ruby
examples <<~DOC
  **Specify a global domain value**

  ```ruby
  macos_userdefaults 'full keyboard access to all controls' do
    key 'AppleKeyboardUIMode'
    value '2'
  end
  ```
DOC
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
<td style="text-align:center">6.10.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/resources/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
