+++
title = "Chef/Ruby/RequireNetHttps"
aliases = ["/workstation/cookstyle/chef_ruby_requirenethttps/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Ruby`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Not Enabled | Yes | All Versions |

net/https is deprecated and just includes net/http and openssl. We should include those directly instead.

## Examples

# bad
require 'net/https'

# good
require 'net/http'
require 'openssl'
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
<td style="text-align:center"><nil></td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
