+++
title = "Chef/Correctness/InvalidPlatformHelper"
aliases = ["/workstation/cookstyle/chef_correctness_invalidplatformhelper/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Correctness`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Pass valid platforms to the `platform?` helper. See [Infra Language: Platform](https://docs.chef.io/infra_language/checking_platforms/#platform-values) for a list of many common platform values.

## Examples

### incorrect

```ruby
platform?('darwin')
platform?('rhel')
platform?('sles')
```

### correct

```ruby
platform?('mac_os_x')
platform?('redhat')
platform?('suse')
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
<td style="text-align:center">5.15.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
