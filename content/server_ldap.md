+++
title = "Active Directory and LDAP"
description = "DESCRIPTION"
draft = false

aliases = "/server_ldap.html"

[menu]
  [menu.docs]
    title = "Active Directory & LDAP"
    identifier = "active directory & ldap/server_ldap.html"
    parent = "chef infra/managing the server"
    weight = 50
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/server_ldap.rst)

The Chef Infra Server supports Active Directory and LDAP authentication,
which enables users to log in to the Chef Infra Server using their
corporate credentials.

Configure LDAP
==============

The Chef Infra Server supports using Active Directory or LDAP for any
user that has an email address in the LDAP directory. This allows those
users to log in to the Chef Infra Server by using their corporate
credentials instead of having a separate username and password.

<div class="warning" markdown="1">

<div class="admonition-title" markdown="1">

Warning

</div>

The following attributes **MUST** be in the user LDAP record:

-   `mail:`
-   `sAMAccountName:` or `uid:`

The following attributes **SHOULD** be in the user LDAP record:

-   `displayname:`
-   `givenname:`
-   `sn:`
-   `c:`
-   `l:`

</div>

To configure the Chef Infra Server to use Active Directory or LDAP do
the following:

1.  Install the Chef management console (if it is not already).

2.  Add the following settings to the `/etc/opscode/chef-server.rb`
    file. These settings must be added to the `chef-server.rb` file on
    each machine in the Chef Infra Server frontend deployment of a High
    Availability installation as well as on Chef servers in a standalone
    installation.

    {{% config_rb_server_settings_ldap %}}

    <div class="note" markdown="1">

    <div class="admonition-title" markdown="1">

    Note

    </div>

    If the chef-server.rb file does not exist, create a file called
    `chef-server.rb` and put it in the `/etc/opscode/` directory.

    </div>

3.  {{% install_chef_server_reconfigure %}}

At this point, all users should be able to use their Active Directory or
LDAP usernames and passwords to log in to the Chef Infra Server.

Test LDAP Connectivity
======================

{{% server_ldap_test %}}
