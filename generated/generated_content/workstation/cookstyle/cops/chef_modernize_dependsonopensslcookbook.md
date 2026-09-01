+++
title = "Chef/Modernize/DependsOnOpensslCookbook"
aliases = ["/workstation/cookstyle/chef_modernize_dependsonopensslcookbook/"]

[menu]
  [menu.workstation]
    title = "DependsOnOpensslCookbook"
    identifier = "chef_workstation/cookstyle/cops/Chef/Modernize/DependsOnOpensslCookbook"
    parent = "chef_workstation/cookstyle/cops/Chef/Modernize"
+++

<!-- vale off -->
<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 14.4+ |

Don't depend on the `openssl` cookbook which was made obsolete by Chef Infra Client 14.4. All `openssl_*` resources are now included directly in Chef Infra Client.

## Examples

```ruby
# bad
depends 'openssl'

# good
# the openssl_* resources ship in Chef Infra Client 14.4+, so use them without a depends
openssl_x509_certificate '/etc/httpd/ssl/mycert.pem' do
  common_name 'www.example.com'
  org 'Example Inc'
  org_unit 'IT'
  country 'US'
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
<td style="text-align:center">7.20.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/metadata.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
