+++
title = "ExecuteTzUtil"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `ExecuteTzUtil`

The full name of the cop is: `Chef/Modernize/ExecuteTzUtil`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | 14.6+ |

Instead of using the execute or powershell_script resources to run the `tzutil` command, use Chef Infra Client's built-in timezone resource which is available in Chef Infra Client 14.6 and later.

## Examples


#### incorrect

```ruby
execute 'set tz' do
  command 'tzutil.exe /s UTC'
end

execute 'tzutil /s UTC'

powershell_script 'set windows timezone' do
  code "tzutil.exe /s UTC"
  not_if { shell_out('tzutil.exe /g').stdout.include?('UTC') }
end
```

#### correct

```ruby
timezone 'UTC'
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
