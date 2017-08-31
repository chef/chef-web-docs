=====================================================
Notes for Open Source Chef Upgrades
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/upgrade_server_open_source_notes.rst>`__

The following sections contain more information about the upgrade process from Open Source Chef to Chef server version 12, including steps for a manual upgrade. Please consult with Chef support about any of these situations if needed.

Background
=====================================================
The following assumptions are made about all upgrades from Open Source Chef version 11.0.0 (or higher) to Chef server version 12.

* An organization must be created. Add the organization name as the vaue for the ``default_orgname`` setting in the ``chef-server.rb`` file. This will ensure that API requests made to the server prior to the upgrade process can still be made after.

Standalone>>Standalone
-----------------------------------------------------
The only supported upgrade path for a Open Source Chef server to Chef server version 12 is from a standalone configuration to a standalone configuration.

Max Database Connections
-----------------------------------------------------
The upgrade tool must be able to connect to PostgreSQL during the upgrade process. In the chef-server.rb file, ensure that the value of ``postgresql['max_connections']`` is greater than the value of ``erchef['db_pool_size']``.

Backup Server Data
-----------------------------------------------------
Like any migration or upgrade, it's strongly recommended to back up your data before doing any of the migration or upgrade steps. While we don't anticipate any issues with the upgrade process itself, it's better to be safe.

Organization Names
-----------------------------------------------------
The Open Source Chef server does not have the concept of organizations. The Chef server version 12 upgrade process will require an organization to be created.

After an upgrade, the organization is an endpoint in the Chef server API. The Chef server API used by the Open Source Chef server does not contain this endpoint. Needless to say, API requests made to the Chef server by the chef-client and knife will fail if the ``/organizations/NAME`` endpoint isn't defined.

To following setting is added to the chef-server.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``default_orgname``
     - The Chef server API used by the Open Source Chef server does not have an ``/organizations/NAME`` endpoint. Use this setting to ensure that migrated Open Source Chef servers are able to connect to the Chef server API. This value should be the same as the name of the organization that was created during the upgrade from Open Source Chef version 11 to Chef server version 12, which means it will be identical to the ``NAME`` part of the ``/organizations`` endpoint in Chef server version 12. Default value: the name of the organization specified during the upgrade process from Open Source Chef 11 to Chef server 12.

Validation Keys
-----------------------------------------------------
The Open Source Chef server does not have the concept of organizations. The Chef server version 12 upgrade process will require an organization to be created.

The Open Source Chef uses a validation key and validation client name to ensure that clients can validate to the Open Source Chef server. In Open Source Chef, this is a generic validation client and key. These two settings in the the client.rb and/or knife.rb files specifiy the generic client and key:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``validation_client_name``
     - The name of the chef-validator key that is used by the chef-client to access the Chef server during the initial chef-client run.
   * - ``validation_key``
     - The location of the file that contains the key used when a chef-client is registered with a Chef server. A validation key is signed using the ``validation_client_name`` for authentication. Default value: ``/etc/chef/validation.pem``.

In Chef server version 12, the server supports multiple organizations and each organization has a unique validation client and key. The upgrade process will create a new validation client and key and will associate their names with the newly-created organization.

The ``default_orgname`` setting will ensure that the existing generic validation client and key will work with the newly-created organization. Post-upgrate, there will be TWO validation clients and validation keys. The organization-specific client and key is not required; in some cases, it may be necessary to reset that validation key through the Chef management console web user interface.

.. note:: The Chef management console web user interface will not be able to reset the generic validation client and key that was migrated from Open Source Chef.

SSL Certificates
-----------------------------------------------------
.. tag server_security_ssl_cert_custom

The Chef server can be configured to use SSL certificates by adding the following settings to the server configuration file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``nginx['ssl_certificate']``
     - The SSL certificate used to verify communication over HTTPS.
   * - ``nginx['ssl_certificate_key']``
     - The certificate key used for SSL communication.

and then setting their values to define the paths to the certificate and key.

.. end_tag

After an upgrade to Chef server 12 from Open Source Chef, you may continue using the SSL certificates that were used with Open Source Chef with Chef server 12. There are two options: move the SSL certificates to a new directory in Chef server 12 or adding two settings to the chef-server.rb file, and then specifying the paths to the directory in which the SSL certificate files are located.

**Move the SSL certificates**

To copy the certificates, move the certificate files located in ``/var/opt/chef-server/nginx/ca`` to ``/var/opt/opscode/nginx/ca``, and then restart the **nginx** service:

   .. code-block:: bash

      $ chef-server-ctl restart nginx

**Add settings to chef-server.rb**

To specify the directory in which the SSL certificates are located, add the following settings and values to the chef-server.rb file:

.. code-block:: ruby

   nginx['ssl_certificate']  = "/path/to/existing/your-host.crt"
   nginx['ssl_certificate_key']  = "/path/to/existing/your-host.key"

Save the file, and then run the following command:

.. code-block:: bash

   $ sudo chef-server-ctl reconfigure

Server Data on Disk
-----------------------------------------------------
After the upgrade process, data related to the upgrade process will remain on the system:

* The data for the Open Source Chef server will be located in a temporary directory that was created as part of the upgrade process. This directory will be located at ``/tmp/chef11-server-data[some_random_string]``, unless the ``--chef11-data-dir`` option is used as part of the ``chef-server-ctl upgrade`` command.
* The data that was transformed by the upgrade process to the Chef server version 12 format will be located in a temporary directory that was created during the upgrade process. This directory will be located at ``/tmp/chef12-server-data[some_random_string]``, unless the ``--chef12-data-dir`` option is used as part of the ``chef-server-ctl upgrade`` command.

To remove this data, post-upgrade, simply delete these directories. The current, default behavior of the upgrade process is to leave this data, in case it's required later.

runsvdir and Services
-----------------------------------------------------
``runsvdir`` is the master process for the service supervisor in runit. For each service in the Chef server, a child process is created in the ``runsvdir`` tree. After the upgrade process, services for the Open Source Chef server are stopped; however, the ``runsvdir`` tree is kept running for the following reasons:

* A user may need to run the upgrade process from Open Source Chef 11 to Chef server 12 more than once
* A user may want to revert the upgrade process and resume using the Open Source Chef 11 server

At the point where no more upgrades to Chef server 12 are required **and** there is no need to be able to run Chef using the Open Source Chef server, ``runsvdir`` should be stopped and prevented from restarting. Optionally, Open Source Chef (along with ``runsvdir``) may be removed from the system entirely.

**Shut down runsvdir, prevent restarts (on reboot of system)**

#. To prevent Open Source Chef from leaving orphaned Chef server 12 processes, run the following command to stop all Chef server 12 processes and remove the ``inittab`` or ``upstart`` configuration files:

   .. code-block:: bash

      $ chef-server-ctl uninstall

#. Run the following command to shut down ``runsvdir`` and prevent restarts:

   .. code-block:: bash

      $ /opt/chef-server/bin/chef-server-ctl uninstall

#. Reconfigure Chef server 12 (and recreate the ``inittab`` or ``upstart`` configuration files):

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Start the Chef server 12 ``runsvdir`` tree and all related processes:

   .. code-block:: bash

      $ chef-server-ctl start

**Shut down runsvdir, and then remove Open Source Chef 11**

#. To prevent Open Source Chef from leaving orphaned Chef server 12 processes, run the following command to stop all Chef server 12 processes and remove the ``inittab`` or ``upstart`` configuration files:

   .. code-block:: bash

      $ chef-server-ctl uninstall

#. Run the following command to shut down ``runsvdir``, prevent restarts, and remove related directories:

   .. code-block:: bash

      $ /opt/chef-server/bin/chef-server-ctl cleanse

#. Reconfigure Chef server 12 (and recreate the ``inittab`` or ``upstart`` configuration files):

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Start the Chef server 12 ``runsvdir`` tree and all related processes:

   .. code-block:: bash

      $ chef-server-ctl start

#. Remove Open Source Chef 11 using the appropriate package manager. For example:

   .. code-block:: bash

      $ dpkg --purge chef-server

   or:

   .. code-block:: bash

      $ rpm -e chef-server

#. Delete the remaining files:

   .. code-block:: bash

      $ rm -rf /opt/chef-server

#. Recreate the symbolic link for ``/usr/bin/chef-server-ctl``:

   .. code-block:: bash

      $ ln -s /opt/opscode/bin/chef-server-ctl /usr/bin/chef-server-ctl

Multiple Upgrades
-----------------------------------------------------
The upgrade process may be run multiple times, as long as Open Source Chef 11 and Chef server version 12 are installed on the system. Any subsequent upgrade process will re-create the temporary directories. Because the default behavior is to append a random string to the directory name, the number of temporary directories created is proportional to the number of upgrade processes run, unless identical directory names are specified using the ``--chef11-data-dir`` and ``--chef12-data-dir`` options during each upgrade.

Email Address
-----------------------------------------------------
The Chef server version 12 server requires that all users provide an email address. During the upgrade process, a default email address (``username@example.com``) is created, where ``username`` is the same user that was specified during the upgrade process. This email address may be changed later, post upgrade via the ``knife user edit`` subcommand or via the Chef management console web user interface.

Cookbook Uploads
-----------------------------------------------------
Sometimes when uploading cookbooks, a race condition may occur that prevents one (or more) cookbooks from finishing the upload process. For example:

.. code-block:: bash

   ......
   Chef Client finished, 32/386 resources updated in 42.23452 seconds
   opscode Reconfigured!
   Ensuring Chef 12 server components are started
   ok: run: bookshelf: (pid 24580) 0s
   ok: run: nginx: (pid 24617) 1s
   ok: run: oc_bifrost: (pid 24626) 0s
   ok: run: oc_id: (pid 24657) 0s
   ok: run: opscode-chef-mover: (pid 24662) 1s
   ok: run: opscode-erchef: (pid 24689) 0s
   ok: run: opscode-expander: (pid 24723) 1s
   ok: run: opscode-expander-reindexer: (pid 24757) 0s
   ok: run: opscode-solr4: (pid 24761) 0s
   ok: run: postgresql: (pid 24389) 26s
   ok: run: rabbitmq: (pid 23835) 39s
   ok: run: redis_lb: (pid 24559) 6s
   Writing knife-ec-backup config to /tmp/knife-ec-backup-config.rb
   Uploading transformed open source Chef 11 server data to Chef 12 server
   WARNING: WebUI not specified. Using /etc/opscode/webui_priv.pem
   WARNING: Unable to detect Chef Server version.
   Restoring users ...
   Updating key for admin
   Updating key for ...
   Restoring org grantmc ...
   Restoring the org admin data
   Restoring the rest of the org
   Updated /clients/chef-webui.json
   Updated /clients/chef-server.json
   Updated /clients/grantmc.json
   Created /cookbooks/iis-2.1.5
   Created /cookbooks/passenger_apache2-2.1.0
   Created /cookbooks/php-1.2.0
   ...
   Created /cookbooks/windows-1.33.1
   Created /cookbooks/windows-1.34.2
   ERROR: internal server error
   Response: internal service error
   Failed uploading transformed data to the Chef 12 server

If this error occurs, re-run the upgrade process, adding the ``--upload-threads`` option set to a value of ``1``:

.. code-block:: bash

   $ chef-server-ctl upgrade --upload-threads 1

This option will ensure that only one cookbook is uploaded at a time. This approach will be slower, but will prevent a race condition (and this error) from occuring. It may also be helpful to run each stage of the upgrade process separately. See the section "Subcommands Reference" below for more information about the individual commands.

Verify Nodes and Cookbooks
=====================================================
.. tag upgrade_verify_nodes_and_cookbooks

Install the latest version of the chef-client on a small number of test nodes. Download all cookbooks, and then and check the following:

* Run ``egrep -L ^name */metadata.rb``. Do they all have a metadata.rb file?
* Does the cookbook name in the metadata.rb file match the name in the run-list? (Some older versions of the chef-client used the cookbook name for the run-list based on the directory name of the cookbook and not the value of the ``cookbook_name`` setting in the metadata.rb file.)
* Do all cookbooks have a metadata.rb file or metadata.json file?
* Do all cookbooks used in the organization also exist in source control?
* Do unused cookbooks (or cookbook versions) exist in source control? Run ``knife cookbook list`` to view a list of cookbooks, and then for each cookbook run ``knife cookbook show COOKBOOK_NAME`` to view its versions. Delete unused cookbook versions with ``knife cookbook delete -v VERSION_NAME``.
* How large is a cookbook? Most cookbooks are quite small, under ~200 KB. Sometimes cookbooks need to be larger than that. For larger cookbooks, consider why they are that large. Do they contain unecessary binary files? Do they have a long git history? Mitigate the size of large cookbooks where possible.

Verify the nodes and clients that are in use:

* Are all nodes and/or clients in use? Clean up any extra nodes and clients. Use the ``knife node list``, ``knife client list``, and ``knife_status``` commands to verify nodes and clients that are in use.
* Use the ``knife_client delete`` command to remove unused clients. Use the ``knife_node delete`` command to remove unused nodes.

Run the test nodes against the Chef server. If the server is also being upgraded, first complete that upgrade process (ideally on a fresh operating system), including processes for any highly available, load balanced, or offloaded services, and then verify the test nodes against the upgraded Chef server.

.. end_tag

Manual Upgrades
=====================================================
The migration process occurs in three steps: download the existing data from the Open Source Chef server, transform that data into the format required for Chef server version 12, and then upload that data to the server.

The ``chef-server-ctl upgrade`` command will handle all three of these steps. Each of these three steps may be done individually, if required.

To upgrade to Chef server 12 from the Open Source Chef server, do the following:

#. Run the following to make sure all services are in a sane state.

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Stop the Open Source Chef server:

   .. code-block:: bash

      $ chef-server-ctl stop

#. Run dpkg or RPM Package Manager on the machine to install Chef server version 12. For dpkg:

   .. code-block:: bash

      $ dpkg -D10 -i /path/to/chef-server-core-<version>.deb

   where ``-D`` enables debugging and ``10`` creates output for each file that is processed during the upgrade. See the man pages for dpkg for more information about this option.

   For RPM Package Manager:

   .. code-block:: bash

      $ rpm -Uvh /path/to/chef-server-core-<version>.rpm

   Chef server 12 is installed to ``/opt/opscode``. (The existing Open Source Chef remains at ``/opt/chef-server``.) From this point, the ``chef-server-ctl`` commands are running against the ``/opt/opscode`` location.

#. Upgrade the machine with the following command:

   .. code-block:: bash

      $ chef-server-ctl chef12-upgrade-download

   When prompted, confirm that the upgrade process should take place.

   This command will download data from the Open Source Chef server and place it into a temporary directory. See the "Subcommand Reference" section below for information about options that may be used with this command.

#. Upgrade the machine with the following command:

   .. code-block:: bash

      $ chef-server-ctl chef12-upgrade-data-transform

   This command will create a temporary directory in which Open Source Chef data is transformed into the Chef server version 12 format. See the "Subcommand Reference" section below for information about options that may be used with this command.

#. Upgrade the machine with the following command:

   .. code-block:: bash

      $ chef-server-ctl chef12-upgrade-upload

   See the "Subcommand Reference" section below for information about options that may be used with this command.

   Before data can be uploaded, an organization must be created. When prompted, enter the organization name, and then a full organization name.

   The name must begin with a lower-case letter or digit, may only contain lower-case letters, digits, hyphens, and underscores, and must be between 1 and 255 characters. For example: ``chef``.

   The full name must begin with a non-white space character and must be between 1 and 1023 characters. For example: ``"Chef Software, Inc."``.

#. The Chef server is automatically restarted. A prompt is displayed that contains details about how to remove any temporarily data that was created during the upgrade process.

Subcommand Reference
-----------------------------------------------------
The following subcommands are used **only** during a manual upgrade and **only** when upgrading from the Open Source Chef server to the Chef server version 12.

Download Data
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``chef12-upgrade-download`` subcommand is used to download data from the Open Source Chef server that was created by the ``upgrade`` subcommand. The downloaded data is placed in a randomly created temporary directory.

**Options**

.. note:: Options for the ``chef12-upgrade-download`` subcommand may only be used when upgrading from Open Source Chef 11 to Chef server 12.

This subcommand has the following options:

``-c``, ``--cleanup-only``
   Use to stop the Open Source Chef server. This option does not download data to or start the Open Source Chef server.

``-d DIRECTORY``, ``--chef11-data-dir DIRECTORY``
   The directory in which Open Source Chef 11 data is located. Default value: a temporary directory.

   .. warning:: The short name for this command is a duplicate short name and should not be used. Use the ``--chef11-data-dir`` long name instead.

``-d``, ``--download-only``
   Use to download data to Chef server 12, and then create the public key file. This option does not start or stop the Open Source Chef server.

``-h``, ``--help``
   Use to show help for the ``chef-server-ctl upgrade`` subcommand.

``-k KEY``, ``--key KEY``
   Save a public key to the specified file name. Default value: ``/etc/chef-server/admin.pem``.

``-s URL``, ``--chef11-server-url URL``
   The URL for the Open Source Chef or Enterprise Chef server, version 11. Default value: ``https://localhost``.

``-S``, ``--setup-only``
   Use to stop Chef server 12, and then start the Open Source Chef server in preparation for downloading data. This option does not download data to or stop the Open Source Chef server.

``-u USER``, ``--user``
   Create a client as an admin client. This is required for any user to access Open Source Chef as an administrator.

Transform Data
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``chef12-upgrade-data-transform`` subcommand is used to prepare a directory that contains Open Source Chef 11 data for upload to Chef server version 12. The transformed data is stored in a randomly created temporary directory.

**Options**

.. note:: Options for the ``chef12-upgrade-data-transform`` subcommand may only be used when upgrading from Open Source Chef 11 to Chef server 12.

This subcommand has the following options:

``-d DIRECTORY``, ``--chef11-data-dir DIRECTORY``
   The directory in which Open Source Chef server 11 data is located. Default value: a temporary directory.

``-e DIRECTORY``, ``--chef12-data-dir DIRECTORY``
   The directory in which Chef server 12 data is located. Default value: a temporary directory.

``-f FULL_NAME``, ``--full-org-name FULL_NAME``
   The full name of the Chef server organization. The full name must begin with a non-white space character and must be between 1 and 1023 characters. For example: ``Chef Software, Inc.``. If this option is not specified, the ``upgrade`` command will prompt for it.

``-h``, ``--help``
   Use to show help for the ``chef-server-ctl upgrade`` subcommand.

``-o ORG_NAME``, ``--org-name ORG_NAME``
   The name of the Chef server organization. The name must begin with a lower-case letter or digit, may only contain lower-case letters, digits, hyphens, and underscores, and must be between 1 and 255 characters. For example: ``chef``. If this option is not specified, the ``upgrade`` command will prompt for it.

Upload Data
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``chef12-upgrade-upload`` subcommand is used to upload data to Chef server version 12.

**Options**

.. note:: Options for the ``chef12-upgrade-upload`` subcommand may only be used when upgrading from Open Source Chef 11 to Chef server 12.

This subcommand has the following options:

``-e DIRECTORY``, ``--chef12-data-dir DIRECTORY``
   The directory in which Chef server version 12 data is located. Default value: a temporary directory.

``-h``, ``--help``
   Use to show help for the ``chef-server-ctl upgrade`` subcommand.

``-o NAME``, ``--org-name NAME``
   The name of the Chef server organization. The name must begin with a lower-case letter or digit, may only contain lower-case letters, digits, hyphens, and underscores, and must be between 1 and 255 characters. For example: ``chef``. If this option is not specified, the ``upgrade`` command will prompt for it.

``-S``, ``--setup-only``
   Use to start Chef server 12 in preparation for uploading data. This option does not upload data to the Chef server.

``-u``, ``--upload-only``
   Use to upload data to Chef server 12. This option requires Chef server 12 to be running.

``-t NUMBER``, ``--upload-threads NUMBER``
   The number of threads to use when migrating cookbooks. Default value: ``10``.

``-x URL``, ``--chef12-server-url URL``
   The URL for the Chef server version 12. Default value: ``https://localhost``.
