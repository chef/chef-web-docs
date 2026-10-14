+++
title = "Chef/Correctness/ExecuteDeleteFile"
aliases = ["/workstation/cookstyle/chef_correctness_executedeletefile/"]

[menu]
  [menu.workstation]
    title = "ExecuteDeleteFile"
    identifier = "chef_workstation/cookstyle/cops/Chef/Correctness/ExecuteDeleteFile"
    parent = "chef_workstation/cookstyle/cops/Chef/Correctness"
+++

<!-- vale off -->
<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Correctness`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

Use the `file` or `directory` resources built into Chef Infra Client with the `:delete` action
to remove files and directories instead of shelling out to `rm`. The resources are idempotent,
report correctly on what they changed, and work without a shell.

The two resources are not interchangeable and the one you pick has to match what is on disk.
`directory` asserts the path really is a directory before deleting, so it raises
`Cannot delete directory[...]` on a file even with `recursive true`, and `file` calls
`File.delete`, so it raises `Errno::EISDIR` on a directory. A `directory` delete also needs
`recursive true` for anything that isn't empty, or it raises `Errno::ENOTEMPTY`.

Only a single `rm` of one path is flagged. A command containing a glob, a shell operator, or
anything beyond the one deletion is left alone, since the `file` and `directory` resources
can't express those.

## Examples

```ruby
# bad -- rm without -r, which the shell will not let you point at a directory
execute 'rm /etc/foo.conf'

# good
file '/etc/foo.conf' do
  action :delete
end

# bad -- a recursive rm of a directory
execute 'delete the thing' do
  command 'rm -rf /opt/thing'
end

# good
directory '/opt/thing' do
  recursive true
  action :delete
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
