.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``ldap``:

``ldap['base_dn']``
   The root LDAP node under which all other nodes exist in the directory structure. For Active Directory, this is typically ``cn=users`` and then the domain. For example:

   .. code-block:: ruby

      'OU=Employees,OU=Domain users,DC=example,DC=com'

   Default value: ``nil``.

``ldap['bind_dn']``
   The distinguished name used to bind to the LDAP server. The user the Chef server will use to perform LDAP searches. This is often the administrator or manager user. This user needs to have read access to all LDAP users that require authentication. The Chef server must do an LDAP search before any user can log in. Many Active Directory and LDAP systems do not allow an anonymous bind. If anonymous bind is allowed, leave the ``bind_dn`` and ``bind_password`` settings blank. If anonymous bind is not allowed, a user with ``READ`` access to the directory is required. This user must be specified as an LDAP distinguished name similar to:

   .. code-block:: ruby

      'CN=user,OU=Employees,OU=Domainuser,DC=example,DC=com'

   Default value: ``nil``.

``ldap['bind_password']``
   The password for the binding user. The password for the user specified by ``ldap['bind_dn']``. Leave this value and ``ldap['bind_dn']`` unset if anonymous bind is sufficient. Default value: ``nil``.

``ldap['group_dn']``
   The distinguished name for a group. When set to the distinguished name of a group, only members of that group can log in. This feature filters based on the ``memberOf`` attribute and only works with LDAP servers that provide such an attribute. In OpenLDAP, the ``memberOf`` overlay provides this attribute. For example, if the value of the ``memberOf`` attribute is ``CN=abcxyz,OU=users,DC=company,DC=com``, then use:

   .. code-block:: ruby

      ldap['group_dn'] = 'CN=user,OU=Employees,DC=example,DC=com'

``ldap['host']``
   The name (or IP address) of the LDAP server. The hostname of the LDAP or Active Directory server. Be sure the Chef server is able to resolve any host names. Default value: ``ldap-server-host``.

``ldap['login_attribute']``
   The LDAP attribute that holds the user's login name. Use to specify the Chef server user name for an LDAP user. Default value: ``sAMAccountName``.

``ldap['port']``
   An integer that specifies the port on which the LDAP server listens. The default value is an appropriate value for most configurations. Default value: ``389`` or ``636`` when ``ldap['encryption']`` is set to ``:simple_tls``.

``ldap['ssl_enabled']``
   Cause the Chef server to connect to the LDAP server using SSL. Default value: ``false``. Must be ``false`` when ``ldap['tls_enabled']`` is ``true``.

   .. note:: Previous versions of the Chef server used the ``ldap['ssl_enabled']`` setting to first enable SSL, and then the ``ldap['encryption']`` setting to specify the encryption type. These settings are deprecated.

``ldap['system_adjective']``
   A descriptive name for the login system that is displayed to users in the Chef server management console. If a value like "corporate" is used, then the Chef management console user interface will display strings like "the corporate login server", "corporate login", or "corporate password." Default value: ``AD/LDAP``.

   .. warning:: This setting is **not** used by the Chef server. It is used only by the Chef management console.

``ldap['timeout']``
   The amount of time (in seconds) to wait before timing out. Default value: ``60000``.

``ldap['tls_enabled']``
   Enable TLS. When enabled, communication with the LDAP server is done via a secure SSL connection on a dedicated port. When ``true``, ``ldap['port']`` is also set to ``636``. Default value: ``false``. Must be ``false`` when ``ldap['ssl_enabled']`` is ``true``.

   .. note:: Previous versions of the Chef server used the ``ldap['ssl_enabled']`` setting to first enable SSL, and then the ``ldap['encryption']`` setting to specify the encryption type. These settings are deprecated.

