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
<tr class="odd">
<td><code>ldap['host']</code> and <code>ldap['port']</code></td>
<td><code>-H [HOST:PORT]</code></td>
</tr>
<tr class="even">
<td><code>ldap['bind_dn']</code></td>
<td><code>-D [BIND_DN]</code></td>
</tr>
<tr class="odd">
<td><code>ldap['bind_password']</code></td>
<td><code>-W</code>; <code>ldapsearch</code> will prompt for this parameter</td>
</tr>
<tr class="even">
<td><code>ldap['base_dn']</code></td>
<td><code>-b [BASE_DN]</code></td>
</tr>
<tr class="odd">
<td><code>ldap['login_attribute']</code></td>
<td>Defaults to <code>SAMAccountName</code></td>
</tr>
</tbody>
</table>

And then from a front end machine (in a high availability or tiered
configuration) or from the Chef Infra Server in a standalone
configuration, run the following command. Be sure to replace the
uppercase placeholders with the values for your organization:

``` bash
$ ldapsearch -LLL -H ldap://HOST:PORT -b 'BASE_DN' -D 'BIND_DN' -W '(LOGIN_ATTRIBUTE=YOUR_LDAP_ACCOUNT_USERNAME)'
```

For example:

``` bash
$ ldapsearch -LLL -H ldap://win-ad1.chef.co:389 -b 'OU=Employees,OU=Domain users,DC=opscodecorp,DC=com' -D 'CN=Robert Forster,OU=Employees,OU=Domain users,DC=opscodecorp,DC=com' -W '(sAMAccountName=rforster)'
```

Output similar to the following is returned:

``` bash
$ ldapsearch -LLL -H ldap://win-ad1.chef.co:389 -b 'OU=Employees,OU=Domain users,DC=opscodecorp,DC=com' -D 'CN=Robert Forster,OU=Employees,OU=Domain users,DC=opscodecorp,DC=com' -W '(sAMAccountName=rforster)'
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

<div class="alert-info">

The `ldapsearch` command may need to be installed on the platform. It is
not included as part of the Chef Infra Server package.

</div>