+++
title = "Chef/Correctness/OpenSSLPasswordHelpers"
aliases = ["/workstation/cookstyle/chef_correctness_opensslpasswordhelpers/"]

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

[Cookstyle cops page](/workstation/cookstyle/cops/)

The Cookstyle cops department: `Chef/Correctness`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | All Versions |

The OpenSSL cookbook provides a deprecated `secure_password` helper in the `Opscode::OpenSSL::Password` class, which should no longer be used. This helper would generate a random password that would be used when a data bag or attribute was no present. The practice of generating passwords to be stored on the node is bad security as it exposes the password to anyone that can view the nodes, and deleting a node deletes the password. Passwords should be retrieved from a secure source for use in cookbooks.

  ### incorrect
  ::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
  basic_auth_password = secure_password

## Examples
<nil>

## Configurable attributes

<table>
<tbody><tr>
<th>Name</th>
<th>Default value</th>
<th>Configurable values</th>
</tr>
<tr>
<td style="text-align:center">Version Added</td>
<td style="text-align:center">6.6.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
