+++
title = "Chef/Modernize/ExecuteArchiveExtract"
aliases = ["/workstation/cookstyle/chef_modernize_executearchiveextract/"]

[menu]
  [menu.workstation]
    title = "ExecuteArchiveExtract"
    identifier = "chef_workstation/cookstyle/cops/Chef/Modernize/ExecuteArchiveExtract"
    parent = "chef_workstation/cookstyle/cops/Chef/Modernize"
+++

<!-- vale off -->
<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | 15.0+ |

Use the archive_file resource built into Chef Infra Client 15+ instead of shelling out to
tar or unzip. The resource extracts tar, tar.gz, tar.bz2, tar.xz, and zip archives, and it
only runs when the archive is newer than what was already extracted, where the shelled out
command re-extracts on every converge.

## Examples

```ruby
# bad
execute 'extract nginx' do
  command "tar xzf #{Chef::Config[:file_cache_path]}/nginx.tar.gz -C /opt/nginx"
end

execute 'unzip -o /tmp/app.zip -d /opt/app'

# good
archive_file 'extract nginx' do
  path "#{Chef::Config[:file_cache_path]}/nginx.tar.gz"
  destination '/opt/nginx'
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
