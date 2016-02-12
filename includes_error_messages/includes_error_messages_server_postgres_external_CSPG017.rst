.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


**Reason**

One (or more) of the |postgresql| predefined users already exists.

**Possible Causes**

* The ``opscode_chef``, ``ospcode_chef_ro``, ``bifrost``, ``bifrost_ro``, ``oc_id``, or ``oc_id_ro`` users already exist on the remote machine
* The ``postgresql['vip']`` setting is configured to a remote host, but ``postgresql['external']`` is not set to ``true``, which causes the ``opscode_chef`` and ``ospcode_chef_ro`` users to be created before the machine is reconfigured, which will return a permissions error
* Existing, valid naming conflicts are present, where the users were created independently of the |chef server|

**Resolution**

* Run the following, if it is safe to do so, to update the user name that is specified in the error message:

  .. code-block:: bash

     DROP ROLE "name-of-user";

  or change the name of the user by updating following settings in the |chef server rb| configuration file:

  .. code-block:: ruby

     oc_id['sql_user'] = 'alternative_username'
     oc_id['sql_ro_user'] = alternative_username_for_ro_access' 
     opscode_erchef['sql_user'] = 'alternative_username'
     opscode_erchef['sql_ro_user'] = 'alternative_username_for_ro_access' 
     oc_bifrost['sql_ro_user'] = 'alternative_username' 
     oc_bifrost['sql_ro_user'] = 'alternative_username_for_ro_access' 
