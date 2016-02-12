.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To configure LDAP for |chef delivery|:

#. From your ``delivery-cluster`` repo on your provisioning node, modify the ``environments/.json`` file as follows with the LDAP attributes you want |chef delivery| to use. If you do not specify an LDAP port, the default port of ``3269`` is used.

   .. code-block:: javascript

      "delivery": {
        "ldap": {
             "ldap_attr_login": "sAMAccountName",
             "ldap_attr_mail": "mail",
             "ldap_attr_full_name": "fullName",
             "ldap_base_dn": "OU=Employees,OU=Domain users,DC=opscodecorp,DC=com",
             "ldap_bind_dn": "ldapbind",
             "ldap_bind_dn_password": "secret123",
             "ldap_encryption": "start_tls",
             "ldap_hosts": ["ldap.tld"],
             "ldap_port": 3269,
             "ldap_timeout": 5000
        }
      }

#. Run the following command (in the example, the environment name is "test"):

   .. code-block:: bash

      $ CHEF_ENV=test rake setup:delivery

Once |chef delivery| is set up, you will have a usable **LDAP** option in the |chef delivery| **Users** page that allows you to find users through your LDAP database.
