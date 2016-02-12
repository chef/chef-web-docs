.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following table describes the LDAP attributes that may be used with |chef delivery|:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``ldap_attr_fullname``
     - The full user name for an |ldap| user. Default value: ``nil``.     
   * - ``ldap_attr_login``
     - The login user name for an |ldap| user. Default value: ``sAMAccountName``.
   * - ``ldap_attr_mail``
     - The email for an |ldap| user. Default value: ``mail``.
   * - ``ldap_base_dn``
     - Base dn to use when searching for users in |ldap|, typically ``OU=Users`` and then the domain. Default value: ``OU=Employees,OU=Domain users,DC=examplecorp,DC=com``.
   * - ``ldap_bind_dn``
     - The user |chef delivery| will use to perform |ldap| searches. This is often the administrator or manager user. This user needs to have read access to all |ldap| users that require authentication. The |chef delivery| server must do an |ldap| search before any user can log in. Many |ldap| systems do not allow an anonymous bind. If anonymous bind is allowed, leave the ``bind_dn`` and ``bind_dn_password`` settings blank. If anonymous bind is not allowed, a user with ``READ`` access to the directory is required. This user must be specified as an |ldap| distinguished name (``dn``). Default value: ``nil``.
   * - ``ldap_bind_dn_password``
     - The password for the user specified by ``ldap['bind_dn']``. Leave this value and ``ldap['bind_dn']`` unset if anonymous bind is sufficient. Default value: ``secret123``.
   * - ``ldap_encryption``
     - The type of encryption used to communicate with |chef delivery|. Default value: ``start_tls``. If tls is not in use, set to ``no_tls``.
   * - ``ldap_hosts``
     - An array of hostname(s) of the |ldap| server. Be sure |chef delivery| is able to resolve any host names. Default value: ``[]``.
   * - ``ldap_port``
     - The default value is an appropriate value for most configurations. Default value: ``3269``.
   * - ``ldap_timeout``
     - Timeout when |chef delivery| connects to |ldap|. Default value: ``5000``.
