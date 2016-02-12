.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``ldap``:

``ldap['base_dn']``
   |ldap base_dn| For |windows ad|, this is typically ``cn=users`` and then the domain. For example:

   .. code-block:: ruby

      'OU=Employees,OU=Domain users,DC=example,DC=com'

   Default value: ``nil``.

``ldap['bind_dn']``
   |ldap bind_dn| The user the |chef server| will use to perform |ldap| searches. This is often the administrator or manager user. This user needs to have read access to all |ldap| users that require authentication. The |chef server| must do an |ldap| search before any user can log in. Many |windows ad| and |ldap| systems do not allow an anonymous bind. If anonymous bind is allowed, leave the ``bind_dn`` and ``bind_password`` settings blank. If anonymous bind is not allowed, a user with ``READ`` access to the directory is required. This user must be specified as an |ldap| distinguished name similar to:

   .. code-block:: ruby

      'CN=user,OU=Employees,OU=Domainuser,DC=example,DC=com'

   Default value: ``nil``.

``ldap['bind_password']``
   |ldap bind_password| The password for the user specified by ``ldap['bind_dn']``. Leave this value and ``ldap['bind_dn']`` unset if anonymous bind is sufficient. Default value: ``nil``.

``ldap['group_dn']``
   |ldap group_dn| When set to the distinguished name of a group, only members of that group can log in. This feature filters based on the ``memberOf`` attribute and only works with |ldap| servers that provide such an attribute. In |open ldap|, the ``memberOf`` overlay provides this attribute. For example, if the value of the ``memberOf`` attribute is ``CN=abcxyz,OU=users,DC=company,DC=com``, then use:

   .. code-block:: ruby

      ldap['group_dn'] = 'CN=user,OU=Employees,DC=example,DC=com'

``ldap['host']``
   |ldap host| The hostname of the |ldap| or |windows ad| server. Be sure the |chef server| is able to resolve any host names. Default value: ``ldap-server-host``.

``ldap['login_attribute']``
   |ldap login_attribute| Use to specify the |chef server| user name for an |ldap| user. Default value: ``sAMAccountName``.

``ldap['port']``
   |ldap port| The default value is an appropriate value for most configurations. Default value: ``389`` or ``636`` when ``ldap['encryption']`` is set to ``:simple_tls``.

``ldap['ssl_enabled']``
   |ldap ssl_enabled| Default value: ``false``. Must be ``false`` when ``ldap['tls_enabled']`` is ``true``.

   .. note:: Previous versions of the |chef server| used the ``ldap['ssl_enabled']`` setting to first enable |ssl|, and then the ``ldap['encryption']`` setting to specify the encryption type. These settings are deprecated.

``ldap['system_adjective']``
   |ldap system_adjective| If a value like "corporate" is used, then the |chef manage| user interface will display strings like "the corporate login server", "corporate login", or "corporate password." Default value: ``AD/LDAP``.

   .. warning:: This setting is **not** used by the |chef server|. It is used only by the |chef manage|.

``ldap['timeout']``
   Default value: ``60000``.

``ldap['tls_enabled']``
   |ldap enable_tls| When ``true``, ``ldap['port']`` is also set to ``636``. Default value: ``false``. Must be ``false`` when ``ldap['ssl_enabled']`` is ``true``.

   .. note:: Previous versions of the |chef server| used the ``ldap['ssl_enabled']`` setting to first enable |ssl|, and then the ``ldap['encryption']`` setting to specify the encryption type. These settings are deprecated.

