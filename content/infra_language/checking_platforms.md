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

## platform?

Use the `platform?` helper method to ensure that certain actions are run for specific platforms. The `platform?` method will return true if one of the listed parameters matches the `node['platform']` attribute that is detected by [Ohai](/ohai) during every Chef Infra Client run.

The syntax for the `platform?` method is as follows:

```ruby
platform?('parameter', 'parameter')
```

where:

- `parameter` is a comma-separated list, each specifying a platform, such as Red Hat, CentOS, or Fedora
- `platform?` method is typically used with an `if`, `elsif`, or `case` statement that contains Ruby code that is specific for the platform, if detected

### platform Values

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
<tr>
<td><code>aix</code></td>
<td>IBM AIX</td>
</tr>
<tr>
<td><code>alibabalinux</code></td>
<td>Alibaba Cloud Linux</td>
</tr>
<tr>
<td><code>amazon</code></td>
<td>Amazon Linux</td>
</tr>
<tr>
<td><code>arch</code></td>
<td>Arch Linux</td>
</tr>
<tr>
<td><code>clearos</code></td>
<td>ClearOS</td>
</tr>
<tr>
<td><code>cloudlinux</code></td>
<td>Cloud Linux OS</td>
</tr>
<tr>
<td><code>cumulus</code></td>
<td>NVIDIA Cumulus Linux</td>
</tr>
<tr>
<td><code>debian</code></td>
<td>Debian GNU/Linux</td>
</tr>
<tr>
<td><code>fedora</code></td>
<td>Fedora</td>
</tr>
<tr>
<td><code>freebsd</code></td>
<td>FreeBSD</td>
</tr>
<tr>
<td><code>gentoo</code></td>
<td>Gentoo Linux</td>
</tr>
<tr>
<td><code>linuxmint</code></td>
<td>Linux Mint</td>
</tr>
<tr>
<td><code>mac_os_x</code></td>
<td>macOS</td>
</tr>
<tr>
<td><code>netbsd</code></td>
<td>NetBSD</td>
</tr>
<tr>
<td><code>openbsd</code></td>
<td>OpenBSD</td>
</tr>
<tr>
<td><code>openindiana</code></td>
<td>OpenIndiana</td>
</tr>
<tr>
<td><code>opensuseleap</code></td>
<td>openSUSE leap</td>
</tr>
<tr>
<td><code>pidora</code></td>
<td>Pidora</td>
</tr>
<tr>
<td><code>raspbian</code></td>
<td>Raspberry Pi OS</td>
</tr>
<tr>
<td><code>rocky</code></td>
<td>Rocky Linux</td>
</tr>
<tr>
<td><code>scientific</code></td>
<td>Scientific Linux</td>
</tr>
<tr>
<td><code>solaris2</code></td>
<td>Oracle Solaris</td>
</tr>
<tr>
<td><code>suse</code></td>
<td>SUSE Enterprise Linux Server.</td>
</tr>
<tr>
<td><code>ubuntu</code></td>
<td>Ubuntu Linux</td>
</tr>
<tr>
<td><code>windows</code></td>
<td>Microsoft Windows</td>
</tr>
<tr>
<td><code>xenserver</code></td>
<td>Citrix XenServer</td>
</tr>
</tbody>
</table>

### Examples

**Installing the cron package on Debian systems**

```ruby
package 'cron' if platform?('debian')
```

**Deleting a file on Red Hat and Debian systems**

```ruby
if platform?('redhat', 'debian')
  file '/etc/some_config' do
    action :remove
  end
end
```

**Installing the correct Firefox package**

{{% resource_if_statement_use_with_platform %}}

## platform_family?

Use the `platform_family?` method to ensure that certain actions are run for specific platform families. The `platform_family?` method will return true if one of the listed parameters matches the `node['platform_family']` attribute that are detected by [Ohai](/ohai) during every Chef Infra Client run.

The syntax for the `platform_family?` method is as follows:

```ruby
platform_family?('parameter', 'parameter')
```

where:

- `'parameter'` is a comma-separated list, each specifying a platform family, such as Debian, or Red Hat Enterprise Linux
- `platform_family?` method is typically used with an `if`, `elsif`, or `case` statement that contains Ruby code that is specific for the platform family, if detected

### platform_family Values

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
<tr>
<td><code>aix</code></td>
<td><code>aix</code> platform.</td>
</tr>
<tr>
<td><code>alpine</code></td>
<td><code>alpine</code> platform.</td>
</tr>
<tr>
<td><code>amazon</code></td>
<td><code>amazon</code> platform.</td>
</tr>
<tr>
<td><code>arch</code></td>
<td><code>arch</code>, <code>manjaro</code>, and <code>antergos</code> platforms.</td>
</tr>
<tr>
<td><code>debian</code></td>
<td><code>debian</code>, <code>ubuntu</code>, <code>linuxmint</code>, <code>raspbian</code>, <code>cumulus</code>, <code>kali</code>, <code>sangoma</code>, and <code>pop</code> platforms.</td>
</tr>
<tr>
<td><code>fedora</code></td>
<td><code>fedora</code>, <code>pidora</code>, and <code>arista_eos</code> platforms</td>
</tr>
<tr>
<td><code>freebsd</code></td>
<td><code>freebsd</code> platform</td>
</tr>
<tr>
<td><code>gentoo</code></td>
<td><code>gentoo</code> platform</td>
</tr>
<tr>
<td><code>mac_os_x</code></td>
<td><code>mac_os_x</code> platform</td>
</tr>
<tr>
<td><code>netbsd</code></td>
<td><code>netbsd</code> platform</td>
</tr>
<tr>
<td><code>openbsd</code></td>
<td><code>openbsd</code> platform</td>
</tr>
<tr>
<td><code>openindiana</code></td>
<td><code>openindiana</code> platform</td>
</tr>
<tr>
<td><code>rhel</code></td>
<td><code>redhat</code>, <code>centos</code>, <code>oracle</code>, <code>rocky</code>, <code>scientific</code>, <code>xenserver</code>, <code>clearos</code>, <code>bigip</code>, <code>parallels</code>, <code>xcp</code>, <code>alibabalinux</code>, and <code>ibm_powerkvm</code> platforms</td>
</tr>
<tr>
<td><code>solaris2</code></td>
<td><code>solaris2</code> platform</td>
</tr>
<tr>
<td><code>suse</code></td>
<td><code>opensuse_leap</code>, <code>suse</code>, and <code>sled</code> platforms</td>
</tr>
<tr>
<td><code>windows</code></td>
<td><code>windows</code> platform</td>
</tr>
</tbody>
</table>

### Examples

For example:

```ruby
platform_family?('gentoo')
```

or:

```ruby
platform_family?('slackware', 'suse', 'arch')
```

**Use a specific binary for a specific platform**

{{< readFile_shortcode file="resource_remote_file_use_platform_family.md" >}}

## value_for_platform

Use the `value_for_platform` method in a recipe to select a value based on the `node['platform']` and `node['platform_version']` attributes. These values are detected by Ohai during every Chef Infra Client run.

The syntax for the `value_for_platform` method is as follows:

```ruby
value_for_platform( ['platform', ...] => { 'version' => 'value' } )
```

where:

- `'platform', ...` is a comma-separated list of platforms, such as Red Hat, openSUSE, or Fedora
- `version` specifies the version of that platform
- Version constraints---`>`, `<`, `>=`, `<=`, `~>`---may be used with `version`; an exception is raised if two version constraints match; an exact match will always take precedence over a match made from a version constraint
- `value` specifies the value that will be used if the node's platform matches the `value_for_platform` method

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

### Operators

{{% cookbooks_version_constraints_operators %}}

### Examples

The following example will set `package_name` to `httpd` for the Red Hat platform and to `apache2` for the Debian platform:

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

The following example will set `package` to `apache-couchdb` for OpenBSD platforms, `dev-db/couchdb` for Gentoo platforms, and `couchdb` for all other platforms:

```ruby
package = value_for_platform(
  'openbsd' => { 'default' => 'apache-couchdb' },
  'gentoo' => { 'default' => 'dev-db/couchdb' },
  'default' => 'couchdb'
)
```

The following example shows using version constraints to specify a value based on the version:

```ruby
value_for_platform(
  'os1' => { '< 1.0' => 'less than 1.0',
             '~> 2.0' => 'version 2.x',
             '>= 3.0' => 'greater than or equal to version 3.0',
             '3.0.1' => '3.0.1 will always use this value' }
)
```

## value_for_platform_family

Use the `value_for_platform_family` method in a recipe to select a value based on the `node['platform_family']` attribute. This value is detected by Ohai during every Chef Infra Client run.

The syntax for the `value_for_platform_family` method is as follows:

```ruby
value_for_platform_family( 'platform_family' => 'value', ... )
```

where:

- `'platform_family' => 'value', ...` is a comma-separated list of platforms, such as Fedora, openSUSE, or Red Hat Enterprise Linux
- `value` specifies the value that will be used if the node's platform family matches the `value_for_platform_family` method

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

The following example will set `package` to `httpd-devel` for the Red Hat Enterprise Linux, Fedora, and openSUSE platforms and to `apache2-dev` for the Debian platform:

```ruby
package = value_for_platform_family(
  ['rhel', 'fedora', 'suse'] => 'httpd-devel',
    'debian' => 'apache2-dev'
)
```
