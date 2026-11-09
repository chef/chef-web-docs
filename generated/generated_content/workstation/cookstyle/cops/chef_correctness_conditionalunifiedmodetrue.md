+++
title = "Chef/Correctness/ConditionalUnifiedModeTrue"
aliases = ["/workstation/cookstyle/chef_correctness_conditionalunifiedmodetrue/"]

[menu]
  [menu.workstation]
    title = "ConditionalUnifiedModeTrue"
    identifier = "chef_workstation/cookstyle/cops/Chef/Correctness/ConditionalUnifiedModeTrue"
    parent = "chef_workstation/cookstyle/cops/Chef/Correctness"
+++

<!-- vale off -->
<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Correctness`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 15.3+ |

Setting `unified_mode true` conditionally leaves a resource running in unified mode on newer
Chef Infra Client releases and in legacy mode on older ones. That's not a coherent thing to
want: the resource has to be written, tested, and debugged against both execution models.

Pick one. Set `unified_mode true` unconditionally and drop support for releases that predate
it, or set `unified_mode false if respond_to?(:unified_mode)` to deliberately opt out of
unified mode everywhere and keep writing the resource in the traditional style.

Only `unified_mode true` is flagged. `unified_mode false` under a guard is the supported way
to opt out and is left alone.

## Examples

```ruby
# bad
unified_mode true if respond_to?(:unified_mode)

# good
unified_mode true

# good - deliberately opting out of unified mode
unified_mode false if respond_to?(:unified_mode)
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
<li><code>**/libraries/*.rb</code></li>
<li><code>**/resources/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
