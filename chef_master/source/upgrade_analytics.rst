=====================================================
Upgrade to |chef analytics_title| 1.3.0
=====================================================

Note that the upgrade process has changed for 1.3.0. Please carefully read the following before upgrading analytics.

Prerequisites
=====================================================
This section describes the prereqs for the upgrade

#. The |chef server| referenced by this Analytics system should already have been upgraded to at least 12.0.3 **or** Enterprise Chef 11.3.
#. The |chef server| must have had ``chef-server-ctl reconfigure`` run.
#. The newly generated ``/etc/opscode-analytics`` directory on the |chef server| must have replaced the existing ``/etc/opscode-analytics`` directory and it's contents on the |chef analytics| server. Specifically, the ``analytics-source.json`` will have changed after being reconfigured by the later release of |chef server|.

Standalone
=====================================================
There are two upgrade paths for 1.3.0. ``pg_partman`` supported partitioning in the database was added in 1.3.0 and is enabled by default. **Using partitions is strongly recommended.**

Upgrade with Paritions
-----------------------------------------------------
Recommended. The following steps describe upgrading |chef analytics| with partitions enabled.

#. (Optional) Purge nodes. You will lose the ability to purge node data post upgrade. Node data is no longer being saved as of 1.2.0, but there might be older data in need of downsizing. If you have disc space concerns, please run this command 1.3.0:

   .. code-block:: bash

      $ opscode-analytics-ctl purge-nodes

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

#. Stop the server:

   .. code-block:: bash

      $ opscode-analytics-ctl stop

#. Reconfigure the services:

   .. code-block:: bash

      $ opscode-analytics-ctl reconfigure

#. Migrate to paritions:

   .. code-block:: bash

      $ opscode-analytics-ctl migrate-partitions

   This step may take awhile. It is recommended you leave |chef analytics| down during this time.

#. Start the services:

   .. code-block:: bash

      $ opscode-analytics-ctl start


Upgrade without Paritions
-----------------------------------------------------
The following steps describe upgrading |chef analytics| with partitions disabled.

#. (Optional) Purge Nodes. You will lose the ability to purge node data post upgrade. Node data is no longer being saved as of 1.2.0, but there might be older data in need of downsizing. If you have disk space concerns, please run this command 1.3.0:

   .. code-block:: bash

      $ opscode-analytics-ctl purge-nodes

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

#. Stop the server:

   .. code-block:: bash

      $ opscode-analytics-ctl stop

#. Reconfigure the services:

   .. code-block:: bash

      $ opscode-analytics-ctl reconfigure

#. Start the services:

   .. code-block:: bash

      $ opscode-analytics-ctl start