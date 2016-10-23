.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The Chef server supports using Active Directory or LDAP for any user that has an email address in the LDAP directory. This allows those users to log in to the Chef server by using their corporate credentials instead of having a separate username and password.

.. warning:: The following attributes **MUST** be in the user LDAP record:

   - ``mail:``
   - ``sAMAccountName:`` or ``uid:``

   The following attributes **SHOULD** be in the user LDAP record:

   - ``displayname:``
   - ``givenname:``
   - ``sn:``
   - ``c:``
   - ``l:``

To configure the Chef server to use Active Directory or LDAP do the following:

#. Install the Chef management console (if it is not already).
#. Add the following settings to the chef-server.rb file. These settings must be added to the chef-server.rb file on each machine in the Chef server frontend deployment of a High Availability installation as well as on Chef servers in a standalone installation.

   .. include:: ../../includes_config/includes_config_rb_server_settings_ldap.rst

   .. note:: If the chef-server.rb file does not exist, create a file called ``chef-server.rb`` and put it in the ``/etc/opscode/`` directory.

#. .. include:: ../../step_install/step_install_chef_server_reconfigure.rst

At this point, all users should be able to use their Active Directory or LDAP usernames and passwords to log in to the Chef server.
