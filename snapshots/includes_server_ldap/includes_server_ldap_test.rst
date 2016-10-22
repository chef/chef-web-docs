.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use ``ldapsearch`` to test the ability of the Chef server to use Active Directory or LDAP. First, translate the Chef server LDAP settings into ``ldapsearch`` parameters:

.. list-table::
   :widths: 200 200
   :header-rows: 1

   * - Chef Server Setting
     - ``ldapsearch`` Parameter
   * - ``ldap['host']`` and ``ldap['port']``
     - ``-H [HOST:PORT]``
   * - ``ldap['bind_dn']``
     - ``-D [BIND_DN]``
   * - ``ldap['bind_password']``
     - ``-W``; ``ldapsearch`` will prompt for this parameter
   * - ``ldap['base_dn']``
     - ``-b [BASE_DN]``
   * - ``ldap['login_attribute']``
     - Defaults to ``SAMAccountName``

And then from a front end machine (in a high availability or tiered configuration) or from the Chef server in a standalone configuration, run the following command. Be sure to replace the uppercase placeholders with the values for your organization:

.. code-block:: bash

   $ ldapsearch -LLL -H ldap://HOST:PORT -b 'BASE_DN' -D 'BIND_DN' -W '(LOGIN_ATTRIBUTE=YOUR_LDAP_ACCOUNT_USERNAME)'

For example:

.. code-block:: bash

   $ ldapsearch -LLL -H ldap://win-ad1.chef.co:389 -b 'OU=Employees,OU=Domain users,DC=opscodecorp,DC=com' -D 'CN=Robert Forster,OU=Employees,OU=Domain users,DC=opscodecorp,DC=com' -W '(sAMAccountName=rforster)'

Output similar to the following is returned:

.. code-block:: bash

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

.. note:: The ``ldapsearch`` command may need to be installed on the platform. It is not included as part of the Chef server package.
