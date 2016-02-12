=====================================================
Upgrade to |chef analytics_title| 1.1
=====================================================

The following sections describe the upgrade process to |chef analytics| 1.1.x.

Prerequisites
=====================================================
This section describes the prereqs for the upgrade

#. The |chef server| referenced by this Analytics system should already have been upgraded to at least 12.0.3 *or* Enterprise Chef 11.3.
#. The |chef server| must have had `chef-server-ctl reconfigure` run.
#. The newly generated `/etc/opscode-analytics` directory on the |chef server| must have replaced the existing `/etc/opscode-analytics` directory and it's contents on the |chef analytics| server. Specifically, the analytics-source.json will have changed after being reconfigured by the later release of |chef server|.

Standalone
=====================================================
This section describes the upgrade process for a standalone configuration:

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

#. Copy in the `/etc/opscode-analytics` directory from the Chef Server

#. Stop the server:

   .. code-block:: bash

      $ opscode-analytics-ctl stop

#. Reconfigure the services:

   .. code-block:: bash

      $ opscode-analytics-ctl reconfigure

#. Start the services:

   .. code-block:: bash
      
      $ opscode-analytics-ctl start

