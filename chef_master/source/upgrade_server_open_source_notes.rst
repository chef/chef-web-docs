=====================================================
Notes for |chef server osc| Upgrades 
=====================================================

The following sections contain more information about the upgrade process from |chef server osc| to |chef server| version 12, including steps for a manual upgrade. Please consult with |company_name| support about any of these situations if needed.

Background
=====================================================
The following assumptions are made about all upgrades from |chef server osc| version 11.0.0 (or higher) to |chef server| version 12.

* An organization must be created. Add the organization name as the vaue for the ``default_orgname`` setting in the ``chef-server.rb`` file. This will ensure that API requests made to the server prior to the upgrade process can still be made after.

Standalone>>Standalone
-----------------------------------------------------
The only supported upgrade path for a |chef server osc| server to |chef server| version 12 is from a standalone configuration to a standalone configuration.

Max Database Connections
-----------------------------------------------------
The upgrade tool must be able to connect to |postgresql| during the upgrade process. In the |chef server rb| file, ensure that the value of ``postgresql['max_connections']`` is greater than the value of ``erchef['db_pool_size']``.

Backup Server Data
-----------------------------------------------------
Like any migration or upgrade, it's strongly recommended to back up your data before doing any of the migration or upgrade steps. While we don't anticipate any issues with the upgrade process itself, it's better to be safe.

Organization Names
-----------------------------------------------------
The |chef server osc| server does not have the concept of organizations. The |chef server| version 12 upgrade process will require an organization to be created.

After an upgrade, the organization is an endpoint in the |api chef server|. The |api chef server| used by the |chef server osc| server does not contain this endpoint. Needless to say, API requests made to the |chef server| by the |chef client| and |knife| will fail if the ``/organizations/NAME`` endpoint isn't defined.

To following setting is added to the |chef server rb| file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``default_orgname``
     - The |api chef server| used by the |chef server osc| server does not have an ``/organizations/NAME`` endpoint. Use this setting to ensure that migrated |chef server osc| servers are able to connect to the |api chef server|. This value should be the same as the name of the organization that was created during the upgrade from |chef server osc| version 11 to |chef server| version 12, which means it will be identical to the ``NAME`` part of the ``/organizations`` endpoint in |chef server| version 12. Default value: the name of the organization specified during the upgrade process from |chef server osc| 11 to |chef server| 12.

Validation Keys
-----------------------------------------------------
The |chef server osc| server does not have the concept of organizations. The |chef server| version 12 upgrade process will require an organization to be created.

The |chef server osc| uses a validation key and validation client name to ensure that clients can validate to the |chef server osc| server. In |chef server osc|, this is a generic validation client and key. These two settings in the the |client rb| and/or |knife rb| files specifiy the generic client and key:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``validation_client_name``
     - |validation_client_name| 
   * - ``validation_key``
     - |validation_key| Default value: ``/etc/chef/validation.pem``.

In |chef server| version 12, the server supports multiple organizations and each organization has a unique validation client and key. The upgrade process will create a new validation client and key and will associate their names with the newly-created organization.

The ``default_orgname`` setting will ensure that the existing generic validation client and key will work with the newly-created organization. Post-upgrate, there will be TWO validation clients and validation keys. The organization-specific client and key is not required; in some cases, it may be necessary to reset that validation key through the |chef manage| web user interface.

.. note:: The |chef manage| web user interface will not be able to reset the generic validation client and key that was migrated from |chef server osc|.

SSL Certificates
-----------------------------------------------------
.. include:: ../../includes_server_security/includes_server_security_ssl_cert_custom.rst

.. include:: ../../includes_server_security/includes_server_security_ssl_cert_custom_set_value_osc_upgrade.rst

**Move the SSL certificates**

.. include:: ../../includes_server_security/includes_server_security_ssl_cert_custom_set_value_osc_upgrade_move.rst

**Add settings to chef-server.rb**

.. include:: ../../includes_server_security/includes_server_security_ssl_cert_custom_set_value_osc_upgrade_config.rst

Server Data on Disk
-----------------------------------------------------
After the upgrade process, data related to the upgrade process will remain on the system:

* The data for the |chef server osc| server will be located in a temporary directory that was created as part of the upgrade process. This directory will be located at ``/tmp/chef11-server-data[some_random_string]``, unless the ``--chef11-data-dir`` option is used as part of the ``chef-server-ctl upgrade`` command.
* The data that was transformed by the upgrade process to the |chef server| version 12 format will be located in a temporary directory that was created during the upgrade process. This directory will be located at ``/tmp/chef12-server-data[some_random_string]``, unless the ``--chef12-data-dir`` option is used as part of the ``chef-server-ctl upgrade`` command.

To remove this data, post-upgrade, simply delete these directories. The current, default behavior of the upgrade process is to leave this data, in case it's required later.

runsvdir and Services
-----------------------------------------------------
``runsvdir`` is the master process for the service supervisor in |runit|. For each service in the |chef server|, a child process is created in the ``runsvdir`` tree. After the upgrade process, services for the |chef server osc| server are stopped; however, the ``runsvdir`` tree is kept running for the following reasons:

* A user may need to run the upgrade process from |chef server osc| 11 to |chef server| 12 more than once
* A user may want to revert the upgrade process and resume using the |chef server osc| 11 server

At the point where no more upgrades to |chef server| 12 are required **and** there is no need to be able to run |chef| using the |chef server osc| server, ``runsvdir`` should be stopped and prevented from restarting. Optionally, |chef server osc| (along with ``runsvdir``) may be removed from the system entirely.

**Shut down runsvdir, prevent restarts (on reboot of system)**

#. To prevent |chef server osc| from leaving orphaned |chef server| 12 processes, run the following command to stop all |chef server| 12 processes and remove the ``inittab`` or ``upstart`` configuration files:

   .. code-block:: bash

      $ chef-server-ctl uninstall

#. Run the following command to shut down ``runsvdir`` and prevent restarts:

   .. code-block:: bash

      $ /opt/chef-server/bin/chef-server-ctl uninstall 

#. Reconfigure |chef server| 12 (and recreate the ``inittab`` or ``upstart`` configuration files):

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Start the |chef server| 12 ``runsvdir`` tree and all related processes:

   .. code-block:: bash

      $ chef-server-ctl start

**Shut down runsvdir, and then remove Open Source Chef 11**

#. To prevent |chef server osc| from leaving orphaned |chef server| 12 processes, run the following command to stop all |chef server| 12 processes and remove the ``inittab`` or ``upstart`` configuration files:

   .. code-block:: bash

      $ chef-server-ctl uninstall

#. Run the following command to shut down ``runsvdir``, prevent restarts, and remove related directories:

   .. code-block:: bash

      $ /opt/chef-server/bin/chef-server-ctl cleanse 

#. Reconfigure |chef server| 12 (and recreate the ``inittab`` or ``upstart`` configuration files):

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Start the |chef server| 12 ``runsvdir`` tree and all related processes:

   .. code-block:: bash

      $ chef-server-ctl start

#. Remove |chef server osc| 11 using the appropriate package manager. For example:

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
The upgrade process may be run multiple times, as long as |chef server osc| 11 and |chef server| version 12 are installed on the system. Any subsequent upgrade process will re-create the temporary directories. Because the default behavior is to append a random string to the directory name, the number of temporary directories created is proportional to the number of upgrade processes run, unless identical directory names are specified using the ``--chef11-data-dir`` and ``--chef12-data-dir`` options during each upgrade.

Email Address
-----------------------------------------------------
The |chef server| version 12 server requires that all users provide an email address. During the upgrade process, a default email address (``username@example.com``) is created, where ``username`` is the same user that was specified during the upgrade process. This email address may be changed later, post upgrade via the ``knife user edit`` subcommand or via the |chef manage| web user interface.

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

Manual Upgrades
=====================================================
The migration process occurs in three steps: download the existing data from the |chef server osc| server, transform that data into the format required for |chef server| version 12, and then upload that data to the server.

The ``chef-server-ctl upgrade`` command will handle all three of these steps. Each of these three steps may be done individually, if required.

To upgrade to |chef server| 12 from the |chef server osc| server, do the following:

#. Run the following to make sure all services are in a sane state.

   .. code-block:: bash
      
      $ chef-server-ctl reconfigure

#. Stop the |chef server osc| server:

   .. code-block:: bash
      
      $ chef-server-ctl stop

#. Run |debian dpkg| or |rpm| on the machine to install |chef server| version 12. For |debian dpkg|:

   .. code-block:: bash
      
      $ dpkg -D10 -i /path/to/chef-server-core-<version>.deb

   where ``-D`` enables debugging and ``10`` creates output for each file that is processed during the upgrade. See the man pages for |debian dpkg| for more information about this option.
   
   For |rpm|:

   .. code-block:: bash
      
      $ rpm -Uvh /path/to/chef-server-core-<version>.rpm

   |chef server| 12 is installed to ``/opt/opscode``. (The existing |chef server osc| remains at ``/opt/chef-server``.) From this point, the ``chef-server-ctl`` commands are running against the ``/opt/opscode`` location.


#. Upgrade the machine with the following command:

   .. code-block:: bash
      
      $ chef-server-ctl chef12-upgrade-download

   When prompted, confirm that the upgrade process should take place.

   This command will download data from the |chef server osc| server and place it into a temporary directory. See the "Subcommand Reference" section below for information about options that may be used with this command.

#. Upgrade the machine with the following command:

   .. code-block:: bash
      
      $ chef-server-ctl chef12-upgrade-data-transform

   This command will create a temporary directory in which |chef server osc| data is transformed into the |chef server| version 12 format. See the "Subcommand Reference" section below for information about options that may be used with this command.

#. Upgrade the machine with the following command:

   .. code-block:: bash
      
      $ chef-server-ctl chef12-upgrade-upload

   See the "Subcommand Reference" section below for information about options that may be used with this command.
   
   Before data can be uploaded, an organization must be created. When prompted, enter the organization name, and then a full organization name.

   |name_rules org| For example: ``chef``.

   |name_rules org_full| For example: ``"Chef Software, Inc."``.

#. The |chef server| is automatically restarted. A prompt is displayed that contains details about how to remove any temporarily data that was created during the upgrade process.

Subcommand Reference
-----------------------------------------------------
The following subcommands are used **only** during a manual upgrade and **only** when upgrading from the |chef server osc| server to the |chef server| version 12.

Download Data
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_upgrade_download.rst

**Options**

.. note:: Options for the ``chef12-upgrade-download`` subcommand may only be used when upgrading from |chef server osc| 11 to |chef server| 12.

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_upgrade_download_options.rst

Transform Data
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_upgrade_data_transform.rst

**Options**

.. note:: Options for the ``chef12-upgrade-data-transform`` subcommand may only be used when upgrading from |chef server osc| 11 to |chef server| 12.

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_upgrade_data_transform_options.rst

Upload Data
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_upgrade_upload.rst

**Options**

.. note:: Options for the ``chef12-upgrade-upload`` subcommand may only be used when upgrading from |chef server osc| 11 to |chef server| 12.

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_upgrade_upload_options.rst