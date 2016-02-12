.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

In a standalone configuration, the |chef analytics| deployment is on a different server from the |chef server|. This allows you to scale |chef analytics| independently from the |chef server|. To set up |chef analytics| in a standalone configuration, an existing |chef server| deployment should already running. |chef analytics| is installed in two steps: configuring the |chef server| for |chef analytics|, and then installing |chef analytics|.

.. warning:: The |chef manage| must be installed on the |chef server| prior to installing |chef analytics|; follow `these steps <https://docs.chef.io/ctl_chef_server.html#install>`_ to install the |chef manage| prior to installing |chef analytics|.

Install |chef analytics|:

#. Download the package from http://downloads.chef.io/analytics/ to the dedicated standalone server that will be used for |chef analytics|. For |redhat| and |centos| 6:

   .. code-block:: bash
      
      $ rpm -Uvh /tmp/opscode-analytics-<version>.rpm

   For |ubuntu|:

   .. code-block:: bash
      
      $ dpkg -i /tmp/opscode-analytics-<version>.deb

   After a few minutes, |chef analytics| will be installed.

Configure the |chef server|. On each server in the |chef server| configuration, do the following:

#. Add the |fqdn| for the |chef analytics| server to ``/etc/opscode/chef-server.rb``. The ending slash is required:

   .. code-block:: bash

	  oc_id['applications'] = { 
	    'analytics' => { 
	      'redirect_uri' => 'https://<analytics_fqdn>/' 
	    } 
	  }

#. Stop the |chef server|:

   .. code-block:: bash

      $ chef-server-ctl stop
	  
#. Enable remote access to |rabbitmq| on the |chef server| backend by adding the following settings to ``/etc/opscode/chef-server.rb``:

   .. code-block:: ruby

      rabbitmq['vip'] = 'BACKEND_VIP'
      rabbitmq['node_ip_address'] = '0.0.0.0'   # see below

   where ``BACKEND_VIP`` is the external IP address for the backend |chef server|. ``node_ip_address`` MUST be set to ``0.0.0.0``.

   .. note:: |analytics rabbitmq_settings| 

#. Reconfigure the |chef server|:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

   This updates the |chef server| and creates the ``actions-source.json`` file, which is required by |chef analytics|, and adds it to the ``/etc/opscode-analytics`` directory on the |chef server|.

#. Restart the |chef server|:
   
   .. code-block:: bash

      $ chef-server-ctl restart

#. Reconfigure the |chef manage|:

   .. code-block:: ruby

      $ opscode-manage-ctl reconfigure


Configure the |chef analytics| standalone server:

#. Copy over the files in the ``/etc/opscode-analytics`` directory from the |chef server| to the standalone |chef analytics| server.

#. Configure the |chef analytics| server by setting the ``analytics_fqdn`` in ``/etc/opscode-analytics/opscode-analytics.rb``. This is the |fqdn| for the |chef analytics| web application. For example:

   .. code-block:: bash

      analytics_fqdn "analytics.example.com"
      topology "standalone"

#. Verify the configuration using the preflight check command:

   .. code-block:: bash

      $ opscode-analytics-ctl preflight-check

   If there are any errors in the preflight check, correct them before carrying on to the next step.

#. Reconfigure the |chef analytics| server on the |chef analytics| server:

   .. code-block:: bash

      $ opscode-analytics-ctl reconfigure

#. Verify the installation on the |chef analytics| server:

   .. code-block:: bash

      $ opscode-analytics-ctl test
