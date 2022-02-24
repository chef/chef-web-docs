+++
title = "OpensslX509Resource"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `OpensslX509Resource`

The full name of the cop is: `Chef/Modernize/OpensslX509Resource`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 14.4+ |

The openssl_x509 resource was renamed to openssl_x509_certificate in Chef Infra Client 14.4. The new resource name should be used.

## Examples


#### incorrect

```ruby
openssl_x509 '/etc/httpd/ssl/mycert.pem' do
  common_name 'www.f00bar.com'
  org 'Foo Bar'
  org_unit 'Lab'
  country 'US'
end
```

#### correct

```ruby
openssl_x509_certificate '/etc/httpd/ssl/mycert.pem' do
  common_name 'www.f00bar.com'
  org 'Foo Bar'
  org_unit 'Lab'
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
<td style="text-align:center">5.6.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
