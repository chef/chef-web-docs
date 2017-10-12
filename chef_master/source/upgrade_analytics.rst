=====================================================
Upgrading Chef Analytics
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/upgrade_analytics.rst>`__

.. tag analytics_legacy

.. note:: This documentation is meant to support existing Chef customers using Analytics.

          If you are a new Chef customer, or are looking to gain better insight into your fleet, try `Chef Automate </chef_automate.html>`__. You'll get a graphical interface and query language that gives you insight into operational, compliance, and workflow events. Download Chef Automate `here <https://downloads.chef.io/automate>`__.


.. end_tag

.. note:: The upgrade process has changed for Chef Analytics 1.3.x. Please carefully read the following before upgrading. Some steps are marked as "(1.2.x -> 1.3.x upgrade only.)". Only run those steps for upgrades of Chef Analytics 1.2.x to 1.3.x.

Prerequisites
=====================================================
This section describes the prerequisites for the upgrade process:

#. The Chef server referenced by this Chef Analytics configuration should already have been upgraded to at least 12.0.3 **or** Enterprise Chef 11.3.
#. The Chef server must have been reconfigured via the ``chef-server-ctl reconfigure`` command.
#. The newly-generated ``/etc/opscode-analytics`` directory on the Chef server must have replaced the existing ``/etc/opscode-analytics`` directory and it's contents on the Chef Analytics server. Specifically, the ``analytics-source.json`` file will have changed after being reconfigured by the later release of Chef server.

Standalone
=====================================================
There are two upgrade paths to Chef Analytics for 1.3.x: with or without partitions. ``pg_partman`` supported partitioning in the database was added in Chef Analytics 1.3.0 and is enabled by default. **Using partitions is strongly recommended.**

Upgrade with Partitions
-----------------------------------------------------
Recommended. The following steps describe upgrading Chef Analytics with partitions enabled.

#. Stop the services:

   .. code-block:: bash

      $ opscode-analytics-ctl stop

#. Run dpkg or RPM Package Manager. For dpkg:

   .. code-block:: bash

      $ dpkg -i /path/to/opscode-analytics-<version>.deb

   For RPM Package Manager:

   .. code-block:: bash

      $ rpm -Uvh /path/to/opscode-analytics-<version>.rpm

#. Run the pre-flight check:

   .. code-block:: bash

      $ opscode-analytics-ctl preflight-check

#. Copy in the ``/etc/opscode-analytics`` directory from the Chef server.

#. Reconfigure the services:

   .. code-block:: bash

      $ opscode-analytics-ctl reconfigure

   .. note:: .. tag chef_license_reconfigure_analytics

             Starting with Chef Analytics 1.4.0, the Chef MLSA must be accepted when reconfiguring the product. If the Chef MLSA has not already been accepted, the reconfigure process will prompt for a ``yes`` to accept it. Or run ``opscode-analytics-ctl reconfigure --accept-license`` to automatically accept the license.

             .. end_tag

#. (1.2.x -> 1.3.x upgrade only.) Migrate to partitions:

   .. code-block:: bash

      $ opscode-analytics-ctl migrate-partitions

   This step may take awhile. It is recommended you leave Chef Analytics down during this time.

#. Start the services:

   .. code-block:: bash

      $ opscode-analytics-ctl start

Upgrade without Partitions
-----------------------------------------------------
The following steps describe upgrading Chef Analytics with partitions disabled.

#. Stop the services:

   .. code-block:: bash

      $ opscode-analytics-ctl stop

#. Run dpkg or RPM Package Manager. For dpkg:

   .. code-block:: bash

      $ dpkg -i /path/to/opscode-analytics-<version>.deb

   For RPM Package Manager:

   .. code-block:: bash

      $ rpm -Uvh /path/to/opscode-analytics-<version>.rpm

#. Run the pre-flight check:

   .. code-block:: bash

      $ opscode-analytics-ctl preflight-check

#. Copy in the ``/etc/opscode-analytics`` directory from the Chef server.

#. Disable partitions. Add the following to your opscode-analytics.rb file:

   ``features['partitioning'] = false``

#. Reconfigure the services:

   .. code-block:: bash

      $ opscode-analytics-ctl reconfigure

   .. note:: .. tag chef_license_reconfigure_analytics

             Starting with Chef Analytics 1.4.0, the Chef MLSA must be accepted when reconfiguring the product. If the Chef MLSA has not already been accepted, the reconfigure process will prompt for a ``yes`` to accept it. Or run ``opscode-analytics-ctl reconfigure --accept-license`` to automatically accept the license.

             .. end_tag

#. Start the services:

   .. code-block:: bash

      $ opscode-analytics-ctl start

   .. code-block:: bash

      $ opscode-analytics-ctl stop

#. Run dpkg or RPM Package Manager. For dpkg:

   .. code-block:: bash

      $ dpkg -i /path/to/opscode-analytics-<version>.deb

   For RPM Package Manager:

   .. code-block:: bash

      $ rpm -Uvh /path/to/opscode-analytics-<version>.rpm

#. Run the pre-flight check:

   .. code-block:: bash

      $ opscode-analytics-ctl preflight-check

#. Copy in the ``/etc/opscode-analytics`` directory from the Chef server.

#. Stop the server:

   .. code-block:: bash

      $ opscode-analytics-ctl stop

#. Reconfigure the services:

   .. code-block:: bash

      $ opscode-analytics-ctl reconfigure

#. Start the services:

   .. code-block:: bash

      $ opscode-analytics-ctl start

