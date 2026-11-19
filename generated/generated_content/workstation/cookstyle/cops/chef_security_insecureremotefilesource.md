+++
title = "Chef/Security/InsecureRemoteFileSource"
aliases = ["/workstation/cookstyle/chef_security_insecureremotefilesource/"]

[menu]
  [menu.workstation]
    title = "InsecureRemoteFileSource"
    identifier = "chef_workstation/cookstyle/cops/Chef/Security/InsecureRemoteFileSource"
    parent = "chef_workstation/cookstyle/cops/Chef/Security"
+++

<!-- vale off -->
<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Security`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Files downloaded over plain HTTP or FTP can be modified in transit, and the resource will
use whatever it receives. Fetch them over HTTPS so the transport is authenticated.

Where an HTTPS endpoint genuinely isn't available, a `checksum` on the resource at least
detects tampering, since the digest is compared before the file is used.

## Examples

```ruby
# bad
remote_file '/tmp/foo.tar.gz' do
  source 'http://example.com/foo.tar.gz'
end

# good
remote_file '/tmp/foo.tar.gz' do
  source 'https://example.com/foo.tar.gz'
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
<td style="text-align:center">9.0.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
