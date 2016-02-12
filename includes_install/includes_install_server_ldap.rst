.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The |chef server| supports using |windows ad| or |ldap| for any user that has an email address in the |ldap| directory. This allows those users to log in to the |chef server| by using their corporate credentials instead of having a separate username and password.

.. warning:: The following attributes **MUST** be in the user LDAP record:
  
   - ``mail:``
   - ``sAMAccountName:`` or ``uid:``

   The following attributes **SHOULD** be in the user LDAP record:

   - ``displayname:``
   - ``givenname:``
   - ``sn:``
   - ``c:``
   - ``l:``

To configure the |chef server| to use |windows ad| or |ldap| do the following:

#. Install the |chef manage| (if it is not already).
#. Add the following settings to the |chef server rb| file. These settings must be added to each machine in the |chef server| deployment, including both frontend and backend servers in a high availability or tiered configuration:

   .. include:: ../../includes_config/includes_config_rb_server_settings_ldap.rst

   .. note:: If the |chef server rb| file does not exist, create a file called ``chef-server.rb`` and put it in the ``/etc/opscode/`` directory.

#. .. include:: ../../step_install/step_install_chef_server_reconfigure.rst

#. .. include:: ../../step_install/step_install_chef_manage_reconfigure.rst

At this point, all users should be able to use their |windows ad| or |ldap| usernames and passwords to log in to the |chef server|.
