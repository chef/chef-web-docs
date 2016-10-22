.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.0

=====================================================
Active Directory and LDAP
=====================================================

Enterprise Chef supports Active Directory and LDAP authentication, allowing users to log in using their corporate credentials instead of having a separate Chef password.

Configure LDAP
=====================================================
.. include:: ../../includes_config/includes_config_rb_chef_server_enterprise_settings_ldap.rst

Reconfigure
-----------------------------------------------------
When this is done, run:

.. code-block:: bash

   $ private-chef-ctl reconfigure

and then run:
  
.. code-block:: bash
      
   $ opscode-manage-ctl reconfigure
	  
At this point, all users will use their Active Directory or LDAP username and password to log in to Enterprise Chef. The first time they log in, they can either create a new account linked to their Active Directory credentials or link an existing Enterprise Chef account to their Active Directory credentials.

Verify
=====================================================
Try logging in to Enterprise Chef by going to the Enterprise Chef management console. Log out if you need to. If Active Directory or LDAP is configured correctly, you will be asked either to create a new Enterprise Chef account or link an existing Enterprise Chef account.

Success!
=====================================================
Congratulations! You have now set up Enterprise Chef to work with Active Directory or LDAP.

At this point, all users will use their Active Directory or LDAP username and password to log in to Enterprise Chef. The first time they log in, they can either create a new account linked to their Active Directory credentials or link an existing Enterprise Chef account to their Active Directory credentials.

