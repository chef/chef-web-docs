.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following table describes the LDAP attributes that may be used with Chef Automate:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``ldap_attr_fullname``
     - The full user name for an LDAP user. Default value: ``nil``.     
   * - ``ldap_attr_login``
     - The login user name for an LDAP user. Default value: ``sAMAccountName``.
   * - ``ldap_attr_mail``
     - The email for an LDAP user. Default value: ``mail``.
   * - ``ldap_base_dn``
     - Base dn to use when searching for users in LDAP, typically ``OU=Users`` and then the domain. Default value: ``OU=Employees,OU=Domain users,DC=examplecorp,DC=com``.
   * - ``ldap_bind_dn``
     - The user Chef Automate will use to perform LDAP searches. This is often the administrator or manager user. This user needs to have read access to all LDAP users that require authentication. The Chef Automate server must do an LDAP search before any user can log in. Many LDAP systems do not allow an anonymous bind. If anonymous bind is allowed, leave the ``bind_dn`` and ``bind_dn_password`` settings blank. If anonymous bind is not allowed, a user with ``READ`` access to the directory is required. This user must be specified as an LDAP distinguished name (``dn``). Default value: ``nil``.
   * - ``ldap_bind_dn_password``
     - The password for the user specified by ``ldap['bind_dn']``. Leave this value and ``ldap['bind_dn']`` unset if anonymous bind is sufficient. Default value: ``secret123``.
   * - ``ldap_encryption``
     - The type of encryption used to communicate with Chef Automate. Default value: ``start_tls``. If tls is not in use, set to ``no_tls``.
   * - ``ldap_hosts``
     - An array of hostname(s) of the LDAP server. Be sure Chef Automate is able to resolve any host names. Default value: ``[]``.
   * - ``ldap_port``
     - The default value is an appropriate value for most configurations. Default value: ``3269``.
   * - ``ldap_timeout``
     - Timeout when Chef Automate connects to LDAP. Default value: ``5000``.
