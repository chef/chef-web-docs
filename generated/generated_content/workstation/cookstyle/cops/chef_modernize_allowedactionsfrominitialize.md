+++
title = "Chef/Modernize/AllowedActionsFromInitialize"
aliases = ["/workstation/cookstyle/chef_modernize_allowedactionsfrominitialize/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Modernize`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | All Versions |

The allowed actions can now be specified using the `allowed_actions` helper instead of using the @actions or @allowed_actions variables in the resource's initialize method. In general we recommend against writing HWRPs, but if HWRPs are necessary you should utilize as much of the resource DSL as possible.

## Examples

### incorrect

```ruby
def initialize(*args)
  super
  @actions = [ :create, :add ]
end

# also bad
def initialize(*args)
  super
  @allowed_actions = [ :create, :add ]
end
```

### correct

```ruby
allowed_actions [ :create, :add ]
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
<li><code>**/resources/*.rb</code></li>
<li><code>**/libraries/*.rb</code></li>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
