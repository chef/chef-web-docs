+++
title = "Chef/Deprecations/EOLAuditModeUsage"
aliases = ["/workstation/cookstyle/chef_deprecations_eolauditmodeusage/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Deprecations`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

The beta Audit Mode for Chef Infra Client was removed in Chef Infra Client 15.0. Users should instead use InSpec and the audit cookbook or the Compliance Phase introduced in Chef Infra Client 17. See https://www.inspec.io/ for more information.

## Examples

### incorrect

```ruby
control_group 'Baseline' do
  control 'SSH' do
    it 'should be listening on port 22' do
      expect(port(22)).to be_listening
    end
  end
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
<td style="text-align:center">5.10.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
