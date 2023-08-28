+++
title = "Chef/Correctness/ConditionalRubyShellout"
aliases = ["/workstation/cookstyle/chef_correctness_conditionalrubyshellout/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Correctness`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

Don't use Ruby to shellout in a `only_if` / `not_if` conditional. Any string value used in an `only_if` / `not_if` is executed in your system's shell and the return code of the command is the result for the `not_if` / `only_if` determination.

## Examples

### incorrect

```ruby
cookbook_file '/logs/foo/error.log' do
  source 'error.log'
  only_if { system('wget https://www.bar.com/foobar.txt -O /dev/null') }
end

cookbook_file '/logs/foo/error.log' do
  source 'error.log'
  only_if { shell_out('wget https://www.bar.com/foobar.txt -O /dev/null').exitstatus == 0 }
end
```

### correct

```ruby
cookbook_file '/logs/foo/error.log' do
  source 'error.log'
  only_if 'wget https://www.bar.com/foobar.txt -O /dev/null'
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
<td style="text-align:center">6.1.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
