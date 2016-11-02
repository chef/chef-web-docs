

=====================================================
LDAP and Active Directory
=====================================================

Enterprise Chef supports Active Directory and LDAP authentication. This allows users to log in to Enterprise Chef by using their corporate credentials instead of a separate password.

Configure LDAP
=====================================================
.. tag config_rb_chef_server_enterprise_settings_ldap

The private-chef.rb file contains the settings required to configure LDAP or Active Directory:

``ldap['base_dn']``
   The root LDAP node under which all other nodes exist in the directory structure. For Active Directory, this is typically ``cn=users`` and then the domain. For example: ``'cn=users,dc=opscode,dc=com'``. Default value: ``nil``.

``ldap['bind_dn']``
   The distinguished name used to bind to the LDAP server. This is often the administrator or manager user. This user needs to have read access to all LDAP users that require authentication. Enterprise Chef must do an LDAP search before any user can log in. Many Active Directory and LDAP systems do not allow an anonymous bind. If anonymous bind is allowed, leave the ``bind_dn`` setting blank. If anonymous bind is not allowed, a user with ``READ`` access to the directory is required. This user must be specified as an LDAP distinguished name similar to ``'cn=user_name,dc=domain_name,dc=com'``. Default value: ``nil``.

``ldap['bind_password']``
   The password for the binding user. Leave this value unset if anonymous bind is sufficient. Default value: ``nil``.

``ldap['encryption']``
   Use to specify the encryption method. Possible values: ``:start_tls`` or ``:simple_tls``. Default value: ``nil``.

``ldap['host']``
   The name (or IP address) of the LDAP server. Be sure the Enterprise Chef is able to resolve any host names. Default value: ``nil``.

``ldap['login_attribute']``
   The LDAP attribute that holds the user's login name. For Active Directory, this is typically ``sAMAccountName``. For OpenLDAP, this is typically ``uid``. Default value: ``sAMAccountName``.

``ldap['port']``
   An integer that specifies the port on which the LDAP server listens. The default value is an appropriate value for most configurations. Default value: ``389``.

``ldap['ssl_enabled']``
   Cause the Chef server to connect to the LDAP server using SSL. Be sure SSL is enabled on the LDAP server and that the ``ldap['port']`` setting is updated with the correct value (often ``636``). Default value: ``false``.

``ldap['system_adjective']``
   A descriptive name for the login system that is displayed to users in the Chef server management console. If a value like "corporate" is used, then the Enterprise Chef user interface will display strings like "the corporate login server", "corporate login", or "corporate password." Default value: ``AD/LDAP``.

.. end_tag

.. note:: If the private-chef.rb file does not exist, create a file called ``private-chef.rb`` and put it in the ``/etc/opscode/`` directory.

When the settings for LDAP or Active Directory are changed in the private-chef.rb file, run the following command after saving those changes:

.. code-block:: bash

   $ private-chef-ctl reconfigure

At this point, all users will be able to use their Active Directory or LDAP username and password to log in to Enterprise Chef. The first time they log in, they can either create a new account linked to their Active Directory credentials or link an existing Enterprise Chef account to their Active Directory credentials.

Login when LDAP and/or AD is Enabled
=====================================================
Enterprise Chef supports Active Directory and LDAP authentication, which enables users to log in using corporate credentials instead of also having a unique password in Enterprise Chef. To set up Active Directory and/or LDAP, follow the instructions in the Active Directory / LDAP installation section of this guide.

When Active Directory or LDAP is enabled, the login page will authenticate users using those credentials.

First-time Login
=====================================================
For users who have not previously logged into Enterprise Chef, they will log in using their Active Directory or LDAP credentials. After the initial login, each user will be presented with a screen asking them if they would like to create a new user with an account name derived from their login name, or if they would like to link their Active Directory or LDAP account to an existing Enterprise Chef user account.

Once the user creates their new account they will be taken to the organization page, just as any other user would upon logging in. The user will not be shown the link account page again after their credentials are linked to a Enterprise Chef account.

Access the WebUI
=====================================================
If a user already has a Enterprise Chef account prior to Active Directory or LDAP being set up, then that user should initially login with their Active Directory or LDAP credentials. They will then be taken to the link account page and have the option of indicating that they already have a Enterprise Chef account.

The user will put in their Enterprise Chef account username and password. This will cause the account to be linked to the user's Active Directory or LDAP credentials, so that when the user logs they will already be using their existing Enterprise Chef account. The user will not be shown the link account page again.

Access when LDAP and/or AD is Down
=====================================================
In the event that the Active Directory or LDAP server goes down or becomes unreachable it is still possible for a user to log into Enterprise Chef as long as they have a system recovery password set on their Enterprise Chef account.

To set or remove a system recovery password for a user, see the instructions in the private-chef-ctl password section of this guide.

Once a user has a system recovery password, they can log into the system by clicking the System Recovery link found on the right hand side of the login page.

Once on the System Recovery page, the user will be asked to enter their username and system recovery password.

Once the user successfully logs in, they will gain access to the system and see the same screens as if Active Directory or LDAP were functioning.

If a user does not have a system recovery password enabled for their account (even if they have a system recovery password set) they will be redirected to the login page and a message will be shown stating that they do not have System Recovery enabled and to contact the system administrator.
