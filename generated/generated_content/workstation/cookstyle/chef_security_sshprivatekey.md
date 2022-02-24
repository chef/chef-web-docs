+++
title = "SshPrivateKey"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `SshPrivateKey`

The full name of the cop is: `Chef/Security/SshPrivateKey`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Do not include plain text SSH private keys in your cookbook code. This sensitive data should be fetched from secrets management systems so that secrets are not uploaded in plain text to the Chef Infra Server or committed to source control systems.

## Examples


#### incorrect

```ruby
file '/Users/bob_bobberson/.ssh/id_rsa' do
  content '-----BEGIN RSA PRIVATE KEY-----\n...\n-----END RSA PRIVATE KEY-----'
  mode '600'
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
<td style="text-align:center">7.28</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
<li><code>**/libraries/*.rb</code></li>
<li><code>**/resources/*.rb</code></li>
<li><code>**/providers/*.rb</code></li>
<li><code>**/recipes/*.rb</code></li>
<li><code>**/attributes/*.rb</code></li>
<li><code>**/definitions/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
