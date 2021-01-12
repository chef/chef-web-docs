+++
title = "Chef Infra Language: Checking Platforms"
draft = false

gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Checking Platforms"
    identifier = "chef_infra/cookbook_reference/infra_language/checking_platforms.md Checking Platforms"
    parent = "chef_infra/cookbook_reference/infra_language"
    weight = 30
+++

### platform?

Use the `platform?` method to ensure that certain actions are run for
specific platform. The `platform?` method will return true if one of the
listed parameters matches the `node['platform']` attribute that is
detected by Ohai during every Chef Infra Client run.

The syntax for the `platform?` method is as follows:

```ruby
platform?('parameter', 'parameter')
```

where:

-   `parameter` is a comma-separated list, each specifying a platform, such as Red Hat, CentOS, or Fedora
-   `platform?` method is typically used with an `if`, `elsif`, or `case` statement that contains Ruby code that is specific for the platform, if detected

#### Parameters

The following parameters can be used with this method:

<table>
<colgroup>
<col style="width: 16%" />
<col style="width: 83%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Platforms</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>aix</code></td>
<td>AIX. All platform variants of AIX return <code>aix</code>.</td>
</tr>
<tr class="even">
<td><code>amazon</code></td>
<td>Amazon Linux</td>
</tr>
<tr class="odd">
<td><code>arch</code></td>
<td>Arch Linux</td>
</tr>
<tr class="even">
<td><code>debian</code></td>
<td>Debian</td>
</tr>
<tr class="odd">
<td><code>fedora</code></td>
<td>Fedora</td>
</tr>
<tr class="even">
<td><code>freebsd</code></td>
<td>FreeBSD. All platform variants of FreeBSD return <code>freebsd</code>.</td>
</tr>
<tr class="odd">
<td><code>gentoo</code></td>
<td>Gentoo</td>
</tr>
<tr class="even">
<td><code>mac_os_x</code></td>
<td>macOS</td>
</tr>
<tr class="odd">
<td><code>netbsd</code></td>
<td>NetBSD. All platform variants of NetBSD return <code>netbsd</code>.</td>
</tr>
<tr class="even">
<td><code>openbsd</code></td>
<td>OpenBSD. All platform variants of OpenBSD return <code>openbsd</code>.</td>
</tr>
<tr class="odd">
<td><code>opensuseleap</code></td>
<td>openSUSE leap</td>
</tr>
<tr class="even">
<td><code>solaris</code></td>
<td>Solaris. For Solaris-related platforms, the <code>platform_family</code> method does not support the Solaris platform family and will default back to <code>platform_family = platform</code>. For example, if the platform is OmniOS, the <code>platform_family</code> is <code>omnios</code>, if the platform is SmartOS, the <code>platform_family</code> is <code>smartos</code>, and so on. All platform variants of Solaris return <code>solaris</code>.</td>
</tr>
<tr class="odd">
<td><code>suse</code></td>
<td>SUSE Enterprise Linux Server.</td>
</tr>
<tr class="even">
<td><code>ubuntu</code></td>
<td>Ubuntu Linux.</td>
</tr>
<tr class="odd">
<td><code>windows</code></td>
<td>Microsoft Windows. All platform variants of Microsoft Windows return <code>windows</code>.</td>
</tr>
</tbody>
</table>

{{< note >}}

Ohai collects platform information at the start of a Chef Infra Client
run and stores that information in the `node['platform']` attribute.

{{< /note >}}

For example:

```ruby
platform?('debian')
```

or:

```ruby
platform?('redhat', 'debian')
```

#### Examples

The following example shows how the `platform?` method can be used in a
recipe.

**Use an if statement with the helper**

{{% resource_if_statement_use_with_platform %}}

### platform_family?

Use the `platform_family?` method to ensure that certain actions are run
for specific platform family. The `platform_family?` method will return
true if one of the listed parameters matches the
`node['platform_family']` attribute that is detected by Ohai during
every Chef Infra Client run.

The syntax for the `platform_family?` method is as follows:

```ruby
platform_family?('parameter', 'parameter')
```

where:

-   `'parameter'` is a comma-separated list, each specifying a platform
    family, such as Debian, or Red Hat Enterprise Linux
-   `platform_family?` method is typically used with an `if`, `elsif`,
    or `case` statement that contains Ruby code that is specific for the
    platform family, if detected

For example:

```ruby
if platform_family?('rhel')
  # do RHEL things
end
```

or:

```ruby
if platform_family?('debian', 'rhel')
  # do things on debian and rhel families
end
```

For example:

```ruby
platform_family?('gentoo')
```

or:

```ruby
platform_family?('slackware', 'suse', 'arch')
```

{{< note >}}

`platform_family?` will default to `platform?` when `platform_family?`
is not explicitly defined.

{{< /note >}}

#### Examples

The following examples show how the `platform_family?` method can be
used in a recipe.

**Use a specific binary for a specific platform**

{{< readFile_shortcode file="resource_remote_file_use_platform_family.md" >}}

### value_for_platform

Use the `value_for_platform` method in a recipe to select a value based
on the `node['platform']` and `node['platform_version']` attributes.
These values are detected by Ohai during every Chef Infra Client run.

The syntax for the `value_for_platform` method is as follows:

```ruby
value_for_platform( ['platform', ...] => { 'version' => 'value' } )
```

where:

-   `'platform', ...` is a comma-separated list of platforms, such as
    Red Hat, openSUSE, or Fedora
-   `version` specifies the version of that platform
-   Version constraints---`>`, `<`, `>=`, `<=`, `~>`---may be used with
    `version`; an exception is raised if two version constraints match;
    an exact match will always take precedence over a match made from a
    version constraint
-   `value` specifies the value that will be used if the node's platform
    matches the `value_for_platform` method

When each value only has a single platform, use the following syntax:

```ruby
value_for_platform(
  'platform' => { 'version' => 'value' },
  'platform' => { 'version' => 'value' },
  'platform' => 'value'
)
```

When each value has more than one platform, the syntax changes to:

```ruby
value_for_platform(
  ['platform', 'platform', ... ] => {
    'version' => 'value'
  },
)
```

#### Operators

{{% cookbooks_version_constraints_operators %}}

#### Examples

The following example will set `package_name` to `httpd` for the Red Hat
platform and to `apache2` for the Debian platform:

```ruby
package_name = value_for_platform(
  ['centos', 'redhat', 'suse', 'fedora' ] => {
    'default' => 'httpd'
  },
  ['ubuntu', 'debian'] => {
    'default' => 'apache2'
  }
)
```

The following example will set `package` to `apache-couchdb` for OpenBSD
platforms, `dev-db/couchdb` for Gentoo platforms, and `couchdb` for all
other platforms:

```ruby
package = value_for_platform(
  'openbsd' => { 'default' => 'apache-couchdb' },
  'gentoo' => { 'default' => 'dev-db/couchdb' },
  'default' => 'couchdb'
)
```

The following example shows using version constraints to specify a value
based on the version:

```ruby
value_for_platform(
  'os1' => { '< 1.0' => 'less than 1.0',
             '~> 2.0' => 'version 2.x',
             '>= 3.0' => 'greater than or equal to version 3.0',
             '3.0.1' => '3.0.1 will always use this value' }
)
```

### value_for_platform_family

Use the `value_for_platform_family` method in a recipe to select a value
based on the `node['platform_family']` attribute. This value is detected
by Ohai during every Chef Infra Client run.

The syntax for the `value_for_platform_family` method is as follows:

```ruby
value_for_platform_family( 'platform_family' => 'value', ... )
```

where:

-   `'platform_family' => 'value', ...` is a comma-separated list of
    platforms, such as Fedora, openSUSE, or Red Hat Enterprise Linux
-   `value` specifies the value that will be used if the node's platform
    family matches the `value_for_platform_family` method

When each value only has a single platform, use the following syntax:

```ruby
value_for_platform_family(
  'platform_family' => 'value',
  'platform_family' => 'value',
  'platform_family' => 'value'
)
```

When each value has more than one platform, the syntax changes to:

```ruby
value_for_platform_family(
  ['platform_family', 'platform_family', 'platform_family', 'platform_family' ] => 'value',
  ['platform_family', 'platform_family'] => 'value',
  'default' => 'value'
)
```

The following example will set `package` to `httpd-devel` for the Red
Hat Enterprise Linux, Fedora, and openSUSE platforms and to
`apache2-dev` for the Debian platform:

```ruby
package = value_for_platform_family(
  ['rhel', 'fedora', 'suse'] => 'httpd-devel',
    'debian' => 'apache2-dev'
)
```