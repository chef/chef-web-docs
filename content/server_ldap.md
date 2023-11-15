+++
title = "Active Directory and LDAP"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/server_ldap.html", "/install_server_post.html"]
product = ["server"]

[menu]
  [menu.legacy]
    title = "Active Directory & LDAP"
    identifier = "legacy/manage/server_ldap.md Active Directory & LDAP"
    parent = "legacy/manage"
+++

The Chef Infra Server supports Active Directory and LDAP authentication,
which enables users to log in to the Chef Infra Server using their
corporate credential and the Manage interface. Without the Manage interface add-on installed,
there is no need to enable the Chef Infra Server LDAP functionality. LDAP is not used with
Supermarket logins, nor with any Chef Infra Client related authentication.

## Configure LDAP

The Chef Infra Server supports using Active Directory or LDAP for any
user that has an email address in the LDAP directory. This allows those
users to log in to the Chef Infra Server by using their corporate
credentials instead of having a separate username and password.

{{< warning >}}

The following attributes **MUST** be in the user LDAP record:

- `mail:`
- `sAMAccountName:` or `uid:`

The following attributes **SHOULD** be in the user LDAP record:

- `displayname:`
- `givenname:`
- `sn:`
- `c:`
- `l:`

{{< /warning >}}

To configure the Chef Infra Server to use Active Directory or LDAP do
the following:

1. Install the Chef management console (if it's not already).

1. Add the following settings to the `/etc/opscode/chef-server.rb`
    file. These settings must be added to the `chef-server.rb` file on
    each machine in the Chef Infra Server frontend deployment of a High
    Availability installation as well as on Chef servers in a standalone
    installation.

    {{< warning >}}

    The following settings **MUST** be in the config file for LDAP
    authentication to Active Directory to work:

    - `base_dn`
    - `bind_dn`
    - `group_dn`
    - `host`

    If those settings are missing, you will get authentication errors and be
    unable to proceed.

    {{< /warning >}}

    This configuration file has the following settings for `ldap`:

    `ldap['base_dn']`

    : The root LDAP node under which all other nodes exist in the
      directory structure. For Active Directory, this is typically
      `cn=users` and then the domain. For example:

      ```ruby
      'OU=Employees,OU=Domain users,DC=example,DC=com'
      ```

      Default value: `nil`.

    `ldap['bind_dn']`

    : The distinguished name used to bind to the LDAP server. The user the
      Chef Infra Server will use to perform LDAP searches. This is often
      the administrator or manager user. This user needs to have read
      access to all LDAP users that require authentication. The Chef Infra
      Server must do an LDAP search before any user can log in. Many
      Active Directory and LDAP systems don't allow an anonymous bind. If
      anonymous bind is allowed, leave the `bind_dn` and `bind_password`
      settings blank. If anonymous bind isn't allowed, a user with `READ`
      access to the directory is required. This user must be specified as
      an LDAP distinguished name similar to:

      ```ruby
      'CN=user,OU=Employees,OU=Domainuser,DC=example,DC=com'
      ```

      {{< note >}}

      If you need to escape characters in a distinguished name, such as
      when using Active Directory, they must be [escaped with a backslash
      escape
      character](https://social.technet.microsoft.com/wiki/contents/articles/5312.active-directory-characters-to-escape.aspx).

      ```ruby
      'CN=example\\user,OU=Employees,OU=Domainuser,DC=example,DC=com'
      ```

      {{< /note >}}

      Default value: `nil`.

    `ldap['bind_password']`

    : Legacy configuration for the password of the binding user. The
      password for the user specified by `ldap['bind_dn']`. Leave this
      value and `ldap['bind_dn']` unset if anonymous bind is sufficient.
      Default value: `nil`. As of Chef Infra Server 12.14, this is no longer the
      preferred command.

      Please use `chef-server-ctl set-secret ldap bind_password` from the
      [Secrets Management](/server/ctl_chef_server/#secrets-management) commands.

      ```bash
      chef-server-ctl set-secret ldap bind_password
      Enter ldap bind_password:  (no terminal output)
      Re-enter ldap bind_password: (no terminal output)
      ```

      Remove a set password using

      ```bash
      chef-server-ctl remove-secret ldap bind_password
      ```

    `ldap['group_dn']`

    : The distinguished name for a group. When set to the distinguished
      name of a group, only members of that group can log in. This feature
      filters based on the `memberOf` attribute and only works with LDAP
      servers that provide such an attribute. In OpenLDAP, the `memberOf`
      overlay provides this attribute. For example, if the value of the
      `memberOf` attribute is `CN=common_name,OU=users,DC=company,DC=com`, then
      use:

      ```ruby
      ldap['group_dn'] = 'CN=abcxyz,OU=users,DC=company,DC=com'
      ```

    `ldap['host']`

    : The name (or IP address) of the LDAP server. The hostname of the
      LDAP or Active Directory server. Be sure the Chef Infra Server is
      able to resolve any host names. Default value: `ldap-server-host`.

    `ldap['login_attribute']`

    : The LDAP attribute that holds the user's login name. Use to specify
      the Chef Infra Server user name for an LDAP user. Default value:
      `sAMAccountName`.

    `ldap['port']`

    : An integer that specifies the port on which the LDAP server listens.
      The default value is an appropriate value for most configurations.
      Default value: `389` or `636` when `ldap['encryption']` is set to
      `:simple_tls`.

    `ldap['ssl_enabled']`

    : Cause the Chef Infra Server to connect to the LDAP server using SSL. Synonymous with simple_tls
      Default value: `false`. Must be `false` when `ldap['tls_enabled']`
      is `true`.

      {{< note >}}

      Enable SSL for Active Directory.

      {{< /note >}}

      {{< note >}}

      Previous versions of the Chef Infra Server used the
      `ldap['ssl_enabled']` setting to first enable SSL, and then the
      `ldap['encryption']` setting to specify the encryption type. These
      settings are deprecated.

      {{< /note >}}

    `ldap['system_adjective']`

    : A descriptive name for the login system that's displayed to users
      in the Chef Infra Server management console. If a value like
      "corporate" is used, then the Chef management console user interface
      will display strings like "the corporate login server," "corporate
      login," or "corporate password." Default value: `AD/LDAP`.

      {{< warning >}}

      This setting **isn't** used by the Chef Infra Server. It's used only by the Chef management console.

      {{< /warning >}}

    `ldap['timeout']`

    : The amount of time (in seconds) to wait before timing out. Default
      value: `60000`.

    `ldap['tls_enabled']`

    : Enable TLS. When enabled, communication with the LDAP server is done
      using a secure SSL connection on a dedicated port. Synonymous with STARTTLS. This mode is rarely used. When `true`,
      `ldap['port']` is also set to `636`. Default value: `false`. Must be
      `false` when `ldap['ssl_enabled']` is `true`.

      {{< note >}}

      Previous versions of the Chef Infra Server used the
      `ldap['ssl_enabled']` setting to first enable SSL, and then the
      `ldap['encryption']` setting to specify the encryption type. These
      settings are deprecated.

      {{< /note >}}

    {{< note >}}

    If the `chef-server.rb` file doesn't exist, create a file called
    `chef-server.rb` and put it in the `/etc/opscode/` directory.

    {{< /note >}}

1. {{< readfile file="content/server/reusable/md/install_chef_server_reconfigure.md" >}}

At this point, all users should be able to use their Active Directory or
LDAP usernames and passwords to log in to the Chef Infra Server.

## Test LDAP Connectivity

Use `ldapsearch` to test the ability of the Chef Infra Server to use
Active Directory or LDAP. First, translate the Chef Infra Server LDAP
settings into `ldapsearch` parameters:

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr class="header">
<th>Chef Infra Server Setting</th>
<th><code>ldapsearch</code> Parameter</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>ldap['host']</code> and <code>ldap['port']</code></td>
<td><code>-H [HOST:PORT]</code></td>
</tr>
<tr>
<td><code>ldap['bind_dn']</code></td>
<td><code>-D [BIND_DN]</code></td>
</tr>
<tr>
<td><code>ldap['bind_password']</code></td>
<td><code>-W</code>; <code>ldapsearch</code> will prompt for this parameter</td>
</tr>
<tr>
<td><code>ldap['base_dn']</code></td>
<td><code>-b [BASE_DN]</code></td>
</tr>
<tr>
<td><code>ldap['login_attribute']</code></td>
<td>Defaults to <code>SAMAccountName</code></td>
</tr>
</tbody>
</table>

And then from a front end machine (in a high availability or tiered
configuration) or from the Chef Infra Server in a standalone
configuration, run the following command. Be sure to replace the
uppercase placeholders with the values for your organization:

```bash
ldapsearch -LLL -H ldap://HOST:PORT -b 'BASE_DN' -D 'BIND_DN' -W '(LOGIN_ATTRIBUTE=YOUR_LDAP_ACCOUNT_USERNAME)'
```

For example:

```bash
ldapsearch -LLL -H ldap://win-ad1.chef.co:389 -b 'OU=Employees,OU=Domain users,DC=opscodecorp,DC=com' -D 'CN=Robert Forster,OU=Employees,OU=Domain users,DC=opscodecorp,DC=com' -W '(sAMAccountName=rforster)'
```

Output similar to the following is returned:

```bash
ldapsearch -LLL -H ldap://win-ad1.chef.co:389 -b 'OU=Employees,OU=Domain users,DC=opscodecorp,DC=com' -D 'CN=Robert Forster,OU=Employees,OU=Domain users,DC=opscodecorp,DC=com' -W '(sAMAccountName=rforster)'
Enter LDAP Password:

dn: CN=Robert Forster,OU=Employees,OU=Domain users,DC=opscodecorp,DC=com
objectClass: top
objectClass: person
objectClass: organizationalPerson
objectClass: user
cn: Robert Forster
sn: Forster
c: 0
givenName: Robert
distinguishedName: CN=Robert Forster,OU=Employees,OU=Domain users,DC=opscodecorp,DC
 =com
```

{{< note >}}

The `ldapsearch` command may need to be installed on the platform. It is
not included as part of the Chef Infra Server package.

{{< /note >}}
