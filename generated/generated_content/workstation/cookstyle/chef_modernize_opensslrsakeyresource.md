+++
title = "OpensslRsaKeyResource"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `OpensslRsaKeyResource`

The full name of the cop is: `Chef/Modernize/OpensslRsaKeyResource`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 14.0+ |

## Examples


#### incorrect

```ruby
openssl_rsa_key '/etc/httpd/ssl/server.key' do
  key_length 2048
end
```

#### correct

```ruby
openssl_rsa_private_key '/etc/httpd/ssl/server.key' do
  key_length 2048
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
