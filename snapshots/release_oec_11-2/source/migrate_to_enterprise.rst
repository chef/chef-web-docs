.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.2

=====================================================
Migrate to Enterprise Chef
=====================================================

.. warning:: The steps described in this topic are typically enough to complete a migration from Open Source Chef to Enterprise Chef (hosted or on premises). That said, Chef would prefer that you consult with our support and/or consulting teams prior to doing a migration. This will help ensure that your migration is completed successfully!

The steps for migrating data from Open Source Chef to Enterprise Chef (hosted or on premises) is described below. The short version:

#. Create an organization
#. For each node, update the ``chef_server_url`` setting in the client.rb files so that it points to the URL for hosted Enterprise Chef
#. Create an empty chef-repo
#. Use versioned cookbooks
#. Run ``knife download`` from the Open Source Chef server
#. Update ``chef_server_url``
#. Run ``knife upload`` to hosted Enterprise Chef
#. Configure permissions for each node

Create an Organization
=====================================================
An organization is the top-level entity in Enterprise Chef. Hosted Enterprise Chef allows a single organization; on premises Enterprise Chef allows multiple organizations.

To add an organization:

#. Open the Chef management console.
#. Click **Administration**.
#. Click **Organizations**.
#. Click **Create**.
#. In the **Create an Organization** dialog box, enter the full and short names for the organization.
#. Click **Create Organization**.

Update client.rb
=====================================================
On each node, the ``chef_server_url`` setting in the client.rb file needs to be updated so that its value is the URL for the hosted Enterprise Chef.

Create an empty repository
=====================================================
The migration process should use a new repository that does not contain any Chef server data. The repository only requires a knife.rb file in the ``.chef/`` directory:

.. code-block:: bash

   mkdir upgrade
   cd upgrade
   mkdir .chef
   vim .chef/knife.rb

The knife.rb file should look similar to the following:

.. code-block:: ruby

   # Knife Configuration File for Migrations to Enterprise Chef
   #
   ######################################################################
   # In order to interact with a Chef Server, three configuration
   # settings are *required*, and you must change them.
   #
   # node_name
   # client_key
   # chef_server_url
   #
   
   node_name ""
    
   client_key "/etc/chef/client.pem"
    
   chef_server_url "http://url_for_open_source_chef_server"

Update knife.rb
=====================================================
On the workstation from which the migration is being done, add the ``versioned_cookbook`` setting to the knife.rb file, and then set it to true. This setting ensures that all cookbooks and cookbook versions are downloaded when using the ``knife download`` subcommand. The knife.rb file should look similar to:

.. code-block:: ruby
   
   current_dir = File.dirname(__FILE__)
   chef_server_url           "https://open-source-chef.opscode.piab"
   client_key                "#{current_dir}/admin.pem"
   node_name                 "admin"
   versioned_cookbooks       "true"
   syntax_check_cache_path   "#{ENV['HOME']}/.chef/syntax_check_cache"
   cookbook_path             ["#{current_dir}/../cookbooks"]
   


Run knife download
=====================================================
To download the data (including run-lists and node attributes) that is being used with the open source Chef server, it must be exported from the open source Chef server so that it can be uploaded to the hosted Enterprise Chef server. Use the ``knife download`` subcommand to perform this task.

To download the entire chef-repo from the Chef server, browse to the top level of the chef-repo and enter:

.. code-block:: bash

   $ knife download /

This command will create subdirectories for clients, cookbooks, data bags, environments, roles, nodes, and users. These can be deleted and modified before uploading to the server.

Update chef_server_url
=====================================================
On the workstation from which the migration is being done, update the value for ``chef_server_url`` to point to the hosted Enterprise Chef URL:

.. code-block:: ruby

   # Knife Configuration File for Migrations to Enterprise Chef
   #
   ######################################################################
   # In order to interact with a Chef Server, three configuration
   # settings are *required*, and you must change them.
   #
   # node_name
   # client_key
   # chef_server_url
   #
   
   node_name ""
    
   client_key "/etc/chef/client.pem"
    
   chef_server_url "https://api.opscode.com"


Run knife upload
=====================================================
To restore the data (including run-lists and node attributes) that was being used with the open source Chef server server, it must be uploaded to the hosted Enterprise Chef server. Use the ``knife upload`` subcommand to perform this task.

.. note:: Make sure that the chef-repo from which the data will be uploaded can authenticate to the hosted Enterprise Chef server before attempting to upload data.

Browse to the top level of the chef-repo and enter:

.. code-block:: bash

   $ knife upload

or from anywhere in the chef-repo, enter:

.. code-block:: bash

   $ knife upload .

A cookbook can be uploaded individually using the ``upload`` argument for the ``knife cookbook`` subcommand.


Configure Permissions
=====================================================
.. include:: ../../includes_server_rbac/includes_server_rbac_clients.rst

.. include:: ../../includes_server_rbac/includes_server_rbac_permissions_key.rst
