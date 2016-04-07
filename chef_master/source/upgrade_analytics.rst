=====================================================
Upgrading |chef analytics_title|
=====================================================

.. note:: The upgrade process has changed for |chef analytics| 1.3.x. Please carefully read the following before upgrading. Some steps are marked as "(1.2.x -> 1.3.x upgrade only.)". Only run those steps for upgrades of |chef analytics| 1.2.x to 1.3.x.

Prerequisites
=====================================================
This section describes the prerequisites for the upgrade process:

#. The |chef server| referenced by this |chef analytics| configuration should already have been upgraded to at least 12.0.3 **or** Enterprise Chef 11.3.
#. The |chef server| must have been reconfigured via the ``chef-server-ctl reconfigure`` command.
#. The newly-generated ``/etc/opscode-analytics`` directory on the |chef server| must have replaced the existing ``/etc/opscode-analytics`` directory and it's contents on the |chef analytics| server. Specifically, the ``analytics-source.json`` file will have changed after being reconfigured by the later release of |chef server|.

Standalone
=====================================================
There are two upgrade paths to |chef analytics| for 1.3.x: with or without partitions. ``pg_partman`` supported partitioning in the database was added in |chef analytics| 1.3.0 and is enabled by default. **Using partitions is strongly recommended.**

Upgrade with Paritions
-----------------------------------------------------
Recommended. The following steps describe upgrading |chef analytics| with partitions enabled.

#. Stop the services:

   .. code-block:: bash

      $ opscode-analytics-ctl stop

#. Run |debian dpkg| or |rpm|. For |debian dpkg|:

   .. code-block:: bash

      $ dpkg -i /path/to/opscode-analytics-<version>.deb

   For |rpm|:

   .. code-block:: bash

      $ rpm -Uvh /path/to/opscode-analytics-<version>.rpm

#. Run the pre-flight check:

   .. code-block:: bash

      $ opscode-analytics-ctl preflight-check

#. Copy in the ``/etc/opscode-analytics`` directory from the |chef server|.

#. Reconfigure the services:

   .. code-block:: bash

      $ opscode-analytics-ctl reconfigure

#. (1.2.x -> 1.3.x upgrade only.) Migrate to paritions:

   .. code-block:: bash

      $ opscode-analytics-ctl migrate-partitions

   This step may take awhile. It is recommended you leave |chef analytics| down during this time.

#. Start the services:

   .. code-block:: bash

      $ opscode-analytics-ctl start


Upgrade without Paritions
-----------------------------------------------------
The following steps describe upgrading |chef analytics| with partitions disabled.

#. Stop the services:

   .. code-block:: bash

      $ opscode-analytics-ctl stop

#. Run |debian dpkg| or |rpm|. For |debian dpkg|:

   .. code-block:: bash

      $ dpkg -i /path/to/opscode-analytics-<version>.deb

   For |rpm|:

   .. code-block:: bash

      $ rpm -Uvh /path/to/opscode-analytics-<version>.rpm

#. Run the pre-flight check:

   .. code-block:: bash

      $ opscode-analytics-ctl preflight-check

#. Copy in the ``/etc/opscode-analytics`` directory from the |chef server|.

#. Disable paritions. Add the following to your |analytics rb| file:

   ``features['partitioning'] = false``

#. Reconfigure the services:

   .. code-block:: bash

      $ opscode-analytics-ctl reconfigure

#. Start the services:

   .. code-block:: bash

      $ opscode-analytics-ctl start
