

=====================================================
chef-solo 
=====================================================

.. warning:: .. tag notes_chef_solo_use_local_mode

             The chef-client :ref:`includes an option called local mode <ctl_chef_client-run-in-local-mode>` (``--local-mode`` or ``-z``), which runs the chef-client against the chef-repo on the local machine as if it were running against a Chef server. Local mode was added to the chef-client in the 11.8 release. If you are running that version of the chef-client (or later), you should consider using local mode instead of using chef-solo.

             .. end_tag

.. tag 4

chef-solo is an open source version of the chef-client that allows using cookbooks with nodes without requiring access to a Chef server. chef-solo runs locally and requires that a cookbook (and any of its dependencies) be on the same physical disk as the node. chef-solo is a limited-functionality version of the chef-client and **does not support** the following:

* Node data storage
* Search indexes
* Centralized distribution of cookbooks
* Environments, including policy settings and cookbook versions
* A centralized API that interacts with and integrates infrastructure components
* Authentication or authorization
* Persistent attributes

.. end_tag

Cookbooks
-----------------------------------------------------
.. tag chef_solo_cookbooks

chef-solo supports two locations from which cookbooks can be run:

* A local directory.
* A URL at which a tar.gz archive is located.

Using a tar.gz archive is the more common approach, but requires that cookbooks be added to an archive. For example:

.. code-block:: bash

   $ tar zcvf chef-solo.tar.gz ./cookbooks

If multiple cookbook directories are being used, chef-solo expects the tar.gz archive to have a directory structure similar to the following::

   cookbooks/
     |---- cbname1/
       |--attributes/ ... etc
     ...
     |---- cbname2/
       |--attributes/

The ``cookbook_path`` variable in the solo.rb file must include both directories. For example:

.. code-block:: bash

   $ tar zcvf chef-solo.tar.gz ./cookbooks ./site-cookbooks

When the tar.gz archive contains all of the cookbooks required by chef-solo, upload it to the web server from which chef-solo will access the archive.

.. end_tag

Attributes
-----------------------------------------------------
.. tag chef_solo_attributes

chef-solo does not interact with the Chef server. Consequently, node-specific attributes must be located in a JSON file on the target system, a remote location (such as Amazon Simple Storage Service (S3)), or a web server on the local network.

The JSON file must also specify the recipes that are part of the run-list. For example:

.. code-block:: javascript

   {
     "resolver": {
       "nameservers": [ "10.0.0.1" ],
       "search":"int.example.com"
     },
     "run_list": [ "recipe[resolver]" ]
   }

.. end_tag

Data Bags
-----------------------------------------------------
.. tag chef_solo_data_bags

A data bag is defined using JSON. chef-solo will look for data bags in ``/var/chef/data_bags``, but this location can be modified by changing the setting in solo.rb. For example, the following setting in solo.rb:

.. code-block:: ruby

   data_bag_path '/var/chef-solo/data_bags'

Create a data bag by creating folders. For example:

.. code-block:: bash

   mkdir /var/chef-solo/data_bags

and:

.. code-block:: bash

   mkdir /var/chef-solo/data_bags/admins

and then create a JSON file in that location:

.. code-block:: javascript

   {
     "id": "ITEM_NAME"
   }

where the name of the file is the ``ITEM_NAME``, for example:

.. code-block:: ruby

   /var/chef-solo/data_bags/admins/ITEM_NAME.json

.. end_tag

Roles
-----------------------------------------------------
.. tag chef_solo_roles

A role is defined using JSON or the Ruby DSL. chef-solo will look for roles in ``/var/chef/roles``, but this location can be modified by changing the setting for ``role_path`` in solo.rb. For example, the following setting in solo.rb:

.. code-block:: ruby

   role_path '/var/chef-solo/roles'

Role data looks like the following in JSON:

.. code-block:: javascript

   {
     "name": "test",
     "default_attributes": { },
     "override_attributes": { },
     "json_class": "Chef::Role",
     "description": "This is just a test role, no big deal.",
     "chef_type": "role",
     "run_list": [ "recipe[test]" ]
   }

and like the following in the Ruby DSL:

.. code-block:: ruby

   name 'test'
   description 'This is just a test role, no big deal.'
   run_list 'recipe[test]'

and finally, JSON data passed to chef-solo:

.. code-block:: ruby

   { 'run_list': 'role[test]' }

.. end_tag

Environments
-----------------------------------------------------
.. tag 4_environments

chef-solo does not have support for environments.

.. end_tag

