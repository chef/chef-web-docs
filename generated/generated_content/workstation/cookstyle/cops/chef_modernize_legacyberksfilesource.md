+++
title = "Chef/Modernize/LegacyBerksfileSource"
aliases = ["/workstation/cookstyle/chef_modernize_legacyberksfilesource/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

There have been many different valid community site / Supermarket URLs to use in a cookbook's Berksfile. These old URLs continue to function via redirects, but should be updated to point to the latest Supermarket URL.

## Examples

### incorrect

```ruby
source 'http://community.opscode.com/api/v3'
source 'https://supermarket.getchef.com'
source 'https://api.berkshelf.com'
site :opscode
```

### correct

```ruby
source 'https://supermarket.chef.io'
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
<td style="text-align:center">5.1.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/Berksfile</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
