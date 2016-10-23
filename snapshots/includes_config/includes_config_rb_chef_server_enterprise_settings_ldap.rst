.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


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
