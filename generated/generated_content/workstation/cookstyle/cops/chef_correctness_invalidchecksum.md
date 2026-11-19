+++
title = "Chef/Correctness/InvalidChecksum"
aliases = ["/workstation/cookstyle/chef_correctness_invalidchecksu/"]

[menu]
  [menu.workstation]
    title = "InvalidChecksum"
    identifier = "chef_workstation/cookstyle/cops/Chef/Correctness/InvalidChecksum"
    parent = "chef_workstation/cookstyle/cops/Chef/Correctness"
+++

<!-- vale off -->
<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Correctness`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

The `checksum` property of the file downloading resources is a SHA-256 digest. An MD5 or
SHA-1 digest can never match, so the resource fails the run with a checksum mismatch rather
than installing anything.

Only digests that are unambiguously the wrong algorithm are flagged: 32 character (MD5) and
40 character (SHA-1) hex strings. Anything else is left alone.

## Examples

```ruby
# bad
remote_file '/tmp/foo.tar.gz' do
  source 'https://example.com/foo.tar.gz'
  checksum 'd41d8cd98f00b204e9800998ecf8427e'
end

# good
remote_file '/tmp/foo.tar.gz' do
  source 'https://example.com/foo.tar.gz'
  checksum 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
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
