=====================================================
chef-solo
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/chef_solo.rst>`__

.. tag chef_solo_summary

chef-solo is a command that executes Chef Infra Client in a way that does not require the Chef Infra Server in order to converge cookbooks. chef-solo uses Chef Infra Client's `Chef local mode </ctl_chef_client.html#run-in-local-mode>`_, and **does not support** the following functionality present in Chef Infra Client / server configurations:

* Centralized distribution of cookbooks
* A centralized API that interacts with and integrates infrastructure components
* Authentication or authorization

.. note:: chef-solo can be run as a daemon.

The chef-solo executable is run as a command-line tool.

.. end_tag

Cookbooks
=====================================================
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

Nodes
=====================================================
Unlike Chef Infra Client, where the node object is stored on the Chef Infra Server, chef-solo stores its node objects as JSON files on local disk. By default, chef-solo stores these files in a ``nodes`` folder in the same directory as your ``cookbooks`` directory. You can control the location of this directory via the ``node_path`` value in your configuration file.

Attributes
=====================================================
chef-solo does not interact with the Chef Infra Server. Consequently, node-specific attributes must be located in a JSON file on the target system, a remote location (such as Amazon Simple Storage Service (S3)), or a web server on the local network.

The JSON file must also specify the recipes that are part of the run-list. For example:

.. code-block:: javascript

   {
     "resolver": {
       "nameservers": [ "10.0.0.1" ],
       "search":"int.example.com"
     },
     "run_list": [ "recipe[resolver]" ]
   }

Data Bags
=====================================================
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

Roles
=====================================================
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

Environments
=====================================================
.. tag chef_solo_environments

An environment is defined using JSON or the Ruby DSL. chef-solo will look for environments in ``/var/chef/environments``, but this location can be modified by changing the setting for ``environment_path`` in solo.rb. For example, the following setting in solo.rb:

.. code-block:: ruby

   environment_path '/var/chef-solo/environments'

Environment data looks like the following in JSON:

.. code-block:: javascript

   {
     "name": "dev",
     "default_attributes": {
       "apache2": {
         "listen_ports": [
           "80",
           "443"
         ]
       }
     },
     "json_class": "Chef::Environment",
       "description": "",
       "cookbook_versions": {
       "couchdb": "= 11.0.0"
     },
     "chef_type": "environment"
     }

and like the following in the Ruby DSL:

.. code-block:: ruby

   name 'environment_name'
   description 'environment_description'
   cookbook OR cookbook_versions  'cookbook' OR 'cookbook' => 'cookbook_version'
   default_attributes 'node' => { 'attribute' => %w(value value etc.) }
   override_attributes 'node' => { 'attribute' => %w(value value etc.) }

.. end_tag

chef-solo (executable)
=====================================================

See `chef-solo (executable) </ctl_chef_solo.html>`__ for complete CTL documentation.
