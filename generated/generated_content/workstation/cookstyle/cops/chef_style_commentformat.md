+++
title = "Chef/Style/CommentFormat"
aliases = ["/workstation/cookstyle/chef_style_commentformat/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Style`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Checks for incorrectly formatted headers

## Examples

### incorrect

```ruby
Copyright 2013-2016 Chef Software, Inc.
Recipe default.rb
Attributes default.rb
License Apache2
Cookbook tomcat
Cookbook Name:: Tomcat
Attributes File:: default
```

### correct

```ruby
Copyright:: 2013-2016 Chef Software, Inc.
Recipe:: default.rb
Attributes:: default.rb
License:: Apache License, Version 2.0
Cookbook:: Tomcat
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
