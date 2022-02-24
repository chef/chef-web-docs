+++
title = "CopyrightCommentFormat"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `CopyrightCommentFormat`

The full name of the cop is: `Chef/Style/CopyrightCommentFormat`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Not Enabled | Yes | All Versions |

Checks for incorrectly formatted copyright comments.

## Examples


#### incorrect

```ruby
Copyright:: 2013-2022 Opscode, Inc.
Copyright:: 2013-2022 Chef Inc.
Copyright:: 2013-2022 Chef Software Inc.
Copyright:: 2009-2010 2013-2022 Chef Software Inc.
Copyright:: Chef Software Inc.
Copyright:: Tim Smith
Copyright:: Copyright (c) 2015-2022 Chef Software, Inc.
```

#### correct

```ruby
Copyright:: 2013-2022 Chef Software, Inc.
Copyright:: 2013-2022 Tim Smith
Copyright:: 2019 37Signals, Inc.
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
<td style="text-align:center">5.0.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
