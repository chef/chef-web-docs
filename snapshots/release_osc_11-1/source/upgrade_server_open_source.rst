.. THIS PAGE DOCUMENTS Open Source Chef server version 11.1

=====================================================
Upgrade the Open Source Chef Server
=====================================================

The Open Source Chef server can be upgraded to newer versions of the Chef server 11 release and also from Chef server 10.

Upgrade to Newer Versions of Chef Server 11
======================================================
To upgrade to newer versions of the Open Source Chef server, do the following:

#. Go to http://www.chef.io/chef/install/.

#. Click the **Chef Server** tab.

#. Select the operating system, version, and architecture.

#. Select the version of Chef server 11 to download, and then click the link that appears to download the package.

#. Install the downloaded package using the correct method for the operating system on which Chef server 11 will be installed.

#. Configure Chef server 11 by running the following command:

   .. code-block:: bash
   
      $ sudo chef-server-ctl reconfigure

   This command will set up all of the required components, including Erchef, RabbitMQ, and PostgreSQL.

#. Restart Chef server 11 by running the following command:

   .. code-block:: bash
   
      $ sudo chef-server-ctl restart


Upgrade from Open Source Chef 11.0.4 (or higher)
-----------------------------------------------------

.. note:: You may use this section for upgrading the Open Source Chef server. You may also use the steps described in the previous section, if you prefer.

.. warning:: This section applies only to upgrading standalone configurations of the Open Source Chef server.

The new upgrade process is simpler. Stop the services, update the package on the system, run the ``upgrade`` subcommand, and then restart the Open Source Chef server.

#. Stop the services:
   
   .. code-block:: bash
   
      $ chef-server-ctl stop

#. After all of the services have shut down, update the package (using the appropriate package manager for the system on which the server is running):
   
   .. code-block:: bash
   
      $ dpkg -i package.deb

#. Upgrade the server itself:
   
   .. code-block:: bash
   
      $ chef-server-ctl upgrade
   
   .. note:: The following error may be present in the logs for PostgreSQL during the upgrade process: ``ERROR: duplicate key value violates unique constraint "checksums_pkey"``. This error does not represent an issue with the upgrade process and can be safely ignored.

#. Restart all of the services:
   
   .. code-block:: bash
   
      $ chef-server-ctl restart

   Sometimes the upgrade process may orphan processes. If orphaned processes are discovered, they can be killed safely.

#. Check the status of everything:
   
   .. code-block:: bash
   
      $ chef-server-ctl status


Upgrade to Open Source Chef 11.1.4 (or higher)
-----------------------------------------------------
.. warning:: This section applies only to upgrading standalone configurations of the Open Source Chef server.

The new upgrade process is simpler. Update the package on the system, and then run the ``upgrade`` subcommand:

#. After all of the services have shut down, update the package (using the appropriate package manager for the system on which the server is running):
   
   .. code-block:: bash
   
      $ dpkg -i package.deb

#. Upgrade the server itself:
   
   .. code-block:: bash
   
      $ chef-server-ctl upgrade
   
   .. note:: The following error may be present in the logs for PostgreSQL during the upgrade process: ``ERROR: duplicate key value violates unique constraint "checksums_pkey"``. This error does not represent an issue with the upgrade process and can be safely ignored.

#. Check the status of everything:
   
   .. code-block:: bash
   
      $ chef-server-ctl status


Upgrade from Open Source Chef 10
=====================================================
Upgrading to Chef server 11 from Chef server 10 is a relatively simple process: install the Chef server 11 and then move the data from Chef server 10 to the new one. Because the Chef server 10 database is CouchDB and the Chef server 11 database is PostgreSQL, the data cannot be moved directly. Instead, use the following knife subcommands:

* ``knife download``
* ``knife list``
* ``knife upload``

These subcommands will be used to download the data from Chef server 10 (as JSON), and then upload it to the Chef server 11 server. This approach bypasses the need to interact directly with either database or having to worry about how the data is stored in either location. 

.. note:: chef-client version 10.x requires the ``knife-essentials`` plugin. To install the latest version of the ``knife-essentials`` plugin for chef-client 10.x, run the following command:

   .. code-block:: bash

      $ gem install knife-essentials

   For more information about ``knife-essentials``, see https://github.com/jkeiser/knife-essentials. ``knife-essentials`` was added to Chef starting with the 11.0 release.


Requirements
-----------------------------------------------------

* A live Chef server 10 server
* A live Chef server 11 server
* A workstation (running knife) that can access both the Chef server 10 and Chef server 11 servers
* The ability to run the ``knife download`` and ``knife upload`` subcommands

Set up Chef Server 10 Access 
-----------------------------------------------------
Use the following steps to configure a workstation so that it can communicate with the Chef server 10 server:

#. Create a directory to use as the location to which data will be downloaded. This topic uses a directory named ``~/transfer``.

#. In the ``~/transfer`` directory, create a file named ``.chef/knife-chef10.rb``. The contents of this file should be similar to the following:

   .. code-block:: ruby

      transfer_repo = File.expand_path('..', File.dirname(__FILE__))
      chef_server_url "http://chef-10.example.com:4000"
      node_name 'chef-webui'
      client_key "#{transfer_repo}/.chef/chef-webui.pem"
      repo_mode 'everything'
      versioned_cookbooks true
      chef_repo_path transfer_repo

   where ``chef_server_url`` is the URL for the Chef server 10 server from which the data will be downloaded and ``node_name`` is the name of the workstation from which knife runs (with admin rights).

#. Copy the private key for the Chef server 10 server to the ``.chef`` directory. The private key is typically located at ``/etc/chef/webui.pem``. For example:

   .. code-block:: bash

      $ cp <local_webui.pem> .chef/chef-webui.pem

#. Verify the configuration by running the following command:

   .. code-block:: bash

      $ knife list /clients

   to return a list of all clients, including ``/clients/chef-webui.json`` and ``/clients/chef-validator.json``.


Download Data
-----------------------------------------------------
To download data from the Chef server 10, run the following command:

.. code-block:: bash

   $ knife download -c .chef/knife-chef10.rb /

This will transfer all of the data on Chef server 10 to the transfer directory.


Set up Chef Server 11 Access 
-----------------------------------------------------
Use the following steps to configure a workstation so that it can communicate with the Chef server 11 server:

#. In the same ``~/transfer`` directory, create a file named ``.chef/knife.rb``. The contents of this file should be similar to the following:

   .. code-block:: ruby

      transfer_repo = File.expand_path('..', File.dirname(__FILE__))
      chef_server_url "https://chef-11.example.com"
      node_name 'admin'
      client_key "#{transfer_repo}/.chef/admin.pem"
      repo_mode 'everything'
      versioned_cookbooks true
      chef_repo_path transfer_repo

   where ``chef_server_url`` is the URL for the Chef server 11 server to which the data will be uploaded.

#. Copy the private key for the Chef server 11 server to the ``.chef`` directory. For example:

   .. code-block:: bash

      $ cp <admin.pem> .chef/admin.pem

#. Verify the configuration by running the following command:

   .. code-block:: bash

      $ knife list /users

   to return a list of all users, including ``/users/admin.json``.


Update chef-validator settings
-----------------------------------------------------
The chef-validator client is no longer special; Chef server 11 requires the ``chef-validator`` flag to be set in order for the chef-validator to be created. 

#. Edit the ``/clients/chef-validator.json`` file---located in the ``~/transfer`` directory---and add ``"validator": true`` as a property, like this:

.. code-block:: javascript

   {
     "name": "chef-validator",
     "public_key": "-----BEGIN PUBLIC KEY-----\
       nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AM235gKCgAQEA8l0+sy05G6YX/SaVsu2k\
       ndwOTIZKLhvfuhp/VcBU432455DTMWyxTR9sdgdRq+mgUqkF4ox/zIwhLG5nyHMLa\
       nFKsKPxUQlS1Jsf2gaoP+RhnswmspJffhF2l593DwSsglTLNtDw5cqhF6YYo7b7cB\
       nywHaWL+O3cSFLd0US7tSoOTeOdnAAwPwrsdfgKQdgfgerCV3Ottn83V8BUCfpnbi\
       nNetytGDnE1Ms9lvYswsW2EqEnzQ+afvlDq5tXu72b1XBs7Y/8JqQz8+3lVHNGKys\
       nh5U6VdI5Br0u1leO0LcffgrgE4@#$fs7/T2MVztXujUN9CoX1a+3siu3HAa8lslo\
       noQIDAQAB\n-----END PUBLIC KEY-----\n",
     "_rev": "1-72a9f16a92108bd794704c075261aeb5",
     "validator": true
   }

#. #. Verify the configuration by running the following command:

   .. code-block:: bash

      $ knife list /clients

   to return a list of all clients, including ``/clients/chef-validator.json``.


Verify the admin public key
-----------------------------------------------------
The ``admin.pem`` private key must be correct for each workstation that will have access to Chef server 11. Chef server 11 has a new user named ``admin``, whereas many instances of Chef server 10 have an admin client named ``admin``. For Chef server 11, knife requires a private key named ``admin.pem``. This naming similarity can be an issue if the name of the client doesn't match the name of the private key.

#. Copy the ``admin.pem`` to each workstation or replace the Chef server 11 admin private key with the old private key. To do this, run the following commands:

   .. code-block:: bash

      $ knife download /users/admin.json
      $ grep public_key clients/admin.json

#. User-hashed passwords are not transferred to or from the Chef server when using the ``knife download`` or ``knife upload`` subcommands. When using these commands to upgrade to a newer version of the Open Source Chef server, each user should run the following command:

   .. code-block:: bash
   
      $ knife user edit user_name
   
   and then add the following to the JSON data:
   
   .. code-block:: javascript
   
      "password":"password_value"

#. Chef server 11 prefers the ``syntax_check_cache_path`` setting for keeping track of cookbook files that have been syntax checked. Add the ``syntax_check_cache_path`` setting to the knife.rb file if it is not already there. For example:

   .. code-block:: ruby
   
      syntax_check_cache_path  '/home/<user>/.chef/syntax_check_cache'

#. Replace the public key in ``/users/admin.json`` with the results of the previous step:

   .. code-block:: bash

      $ knife upload /users/admin.json
      $ cp <Chef 10 admin.pem> .chef/admin.pem

#. Remove the following:

   .. code-block:: bash

      $ rm /clients/admin.json

#. Verify the configuration by running the following command:

   .. code-block:: bash

      $ knife list /users

   to return a list of all users, including ``/users/admin.json``.


Upload Data
-----------------------------------------------------
To upload data to the Chef server 11, run the following command:

.. code-block:: bash

   $ knife upload /

This will transfer all of the data in the transfer directory to Chef server 11.


Last Steps
-----------------------------------------------------
At this point, the Chef server 11 should have all of the data that used to be on the Chef server 10. Point the DNS or load balancer at the new Chef server. The chef-client should continue to run properly on all nodes and each workstation should be able to manage objects on the Chef server using knife. If issues remain, try the IRC channel or email the chef@lists.chef.io discussion alias. If ``knife-essentials`` is the issue, file an issue in GitHub or check the IRC channel.
