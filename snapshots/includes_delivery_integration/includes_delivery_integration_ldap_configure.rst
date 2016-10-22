.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To configure LDAP for Chef Automate:

#. Open ``/etc/delivery/delivery.rb`` and enter the LDAP attributes you want Chef Automate to use. If you do not specify an LDAP port, the default port of ``3269`` is used.

   .. code-block:: ruby

      delivery['ldap_hosts'] = ["ldap.tld"]
      delivery['ldap_port'] = 3269
      delivery['ldap_timeout'] = 5000
      delivery['ldap_base_dn'] = "OU=Employees,OU=Domain users,DC=opscodecorp,DC=com"
      delivery['ldap_bind_dn'] = "ldapbind"
      delivery['ldap_bind_dn_password'] = "secret123"
      delivery['ldap_encryption'] = "start_tls"
      delivery['ldap_attr_login'] = 'sAMAccountName'
      delivery['ldap_attr_mail'] = 'mail'
      delivery['ldap_attr_full_name'] = 'fullName'

#. Run the following command to complete the configuration process:

   .. code-block:: bash

      $ sudo delivery-ctl reconfigure

Once Chef Automate is set up, you will have a usable **LDAP** option in the Chef Automate **Users** page that allows you to find users through your LDAP database.
