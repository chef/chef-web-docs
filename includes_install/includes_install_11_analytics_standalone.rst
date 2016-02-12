.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

In a standalone configuration, the |chef analytics| deployment is on a different machine from |chef server oec|. This allows you to scale |chef analytics| independantly from |chef server oec|. To set up |chef analytics| in a standalone configuration,  you should have an existing |chef server| deployment already running. First run the following steps on the |chef server| instances:

#. Download the package from http://downloads.chef.io/analytics/.
#. Enable the |chef server| deployment to publish to |chef actions| by adding the following line to ``/etc/opscode/private-chef.rb``:

   .. code-block:: bash

      dark_launch['actions'] = true

#. Stop the |chef server|:

   .. code-block:: bash

      $ private-chef-ctl stop
	  
#. Enable remote access to |rabbitmq| on the |chef server| backend server by adding the following settings to ``/etc/opscode/private-chef.rb``:

   .. code-block:: ruby

      rabbitmq['vip'] = 'BACKEND_VIP'
      rabbitmq['node_ip_address'] = ''

   where ``BACKEND_VIP`` is the external IP address for the backend |chef server|. ``node_ip_address`` MUST be set to ``0.0.0.0``.

   .. note:: |analytics rabbitmq_settings| 

#. Reconfigure the |chef server|:

   .. code-block:: bash

      $ private-chef-ctl reconfigure

#. Restart the |chef server|:
   
   .. code-block:: bash

      $ private-chef-ctl start

#. If you are on |chef server| 11.1.8 you need to manually copy a single file from ``/etc/opscode`` to ``/etc/opscode-analytics``:

   .. code-block:: bash

      $ cp /etc/opscode/webui_priv.pem /etc/opscode-analytics

Now run the following steps on your |chef analytics| standalone instance:

#. Install the |chef analytics| package on the standalone |chef analytics| server. For example on |ubuntu|:

   .. code-block:: bash

      $ dpkg -i opscode-analytics_1.0.0-1_amd64.deb

#. Copy over the ``/etc/opscode-analytics`` directory from the |chef server| to the standalone |chef analytics| server.

#. Configure the |chef analytics| server by setting the ``analytics_fqdn`` in ``/etc/opscode-analytics/opscode-analytics.rb``. This is the |fqdn| for the |chef analytics| web application. For example:

   .. code-block:: bash

      analytics_fqdn "analytics.example.com"
      topology "standalone"

#. Verify your configuration with the preflight check tool:

   .. code-block:: bash

      $ opscode-analytics-ctl preflight-check

   If there are any errors in the preflight check, correct them before carrying on to the next step.

#. Reconfigure the |chef analytics| server:

   .. code-block:: bash

      $ opscode-analytics-ctl reconfigure

#. Verify the installation:

   .. code-block:: bash

      $ opscode-analytics-ctl test
