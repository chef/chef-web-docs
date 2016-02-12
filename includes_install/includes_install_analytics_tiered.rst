.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

In a tiered configuration, the |chef analytics| deployment is on different servers from the |chef server|, with a single backend and multiple load-balanced frontends. In a tiered configuration, an existing |chef server| deployment should already running. 

|chef analytics| is installed in the following steps: 

* Configuring the |chef server| for |chef analytics|
* Installing |chef analytics| on the backend
* Installing |chef analytics| on the frontends

.. warning:: The |chef manage| must be installed on the |chef server| prior to installing |chef analytics|; follow `these steps <https://docs.chef.io/ctl_chef_server.html#install>`_ to install the |chef manage| prior to installing |chef analytics|.

Install |chef analytics| on the backend machine:

#. Download the package from http://downloads.chef.io/analytics/ to the machines that will be used for the |chef analytics| deployment. For |redhat| and |centos| 6:

   .. code-block:: bash
      
      $ rpm -Uvh /tmp/opscode-analytics-<version>.rpm

   For |ubuntu|:

   .. code-block:: bash
      
      $ dpkg -i /tmp/opscode-analytics-<version>.deb

   After a few minutes, |chef analytics| will be installed.

Configure the |chef server|. On each machine in the |chef server| configuration, do the following:

#. On each of the |chef server| machines, add the |fqdn| for the |chef analytics| frontend server to ``/etc/opscode/chef-server.rb``. The ending slash is required:

   .. code-block:: bash

	  oc_id['applications'] = { 
	    'analytics' => { 
	      'redirect_uri' => 'https://<analytics_fe_fqdn>/' 
	    } 
	  }

#. On the |chef server| backend, stop the |chef server|:

   .. code-block:: bash

      $ chef-server-ctl stop
	  
#. On the |chef server| backend, enable remote access to |rabbitmq| on the |chef server| backend machine by adding the following settings to ``/etc/opscode/chef-server.rb``:

   .. code-block:: ruby

      rabbitmq['vip'] = 'BACKEND_VIP'
      rabbitmq['node_ip_address'] = '0.0.0.0'   # see below

   where ``BACKEND_VIP`` is the external IP address for the backend |chef server|. ``node_ip_address`` MUST be set to ``0.0.0.0``.

   .. note:: |analytics rabbitmq_settings| 

#. Reconfigure the |chef server|:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

   This updates the |chef server| and creates the ``actions-source.json`` file, which is required by |chef analytics|, and adds it to the ``/etc/opscode-analytics`` directory on the |chef server|.

#. Restart the |chef server| backend:
   
   .. code-block:: bash

      $ chef-server-ctl restart

#. Reconfigure the |chef manage|:

   .. code-block:: ruby

      $ opscode-manage-ctl reconfigure





Configure the |chef analytics| backend:

#. Copy over the files in the ``/etc/opscode-analytics`` directory from the |chef server| server to the backend |chef analytics| machine.

#. Edit the ``opscode-analytics.rb`` file on the backend |chef analytics| server:

   .. code-block:: bash

      analytics_fqdn "<fe_fqdn>"
      topology "tier"
      server "<be_fqdn>",
        :ipaddress => "<be_ip>",
        :role => "backend",
        :bootstrap => true
      server "<fe_fqdn>",
        :ipaddress => "<fe_ip>",
        :role => "frontend"
      backend_vip "<be_fqdn>",
        :ipaddress => "<be_ip>"

#. On the backend |chef analytics| server, verify the configuration using the preflight check command:

   .. code-block:: bash

      $ opscode-analytics-ctl preflight-check

   If there are any errors in the preflight check, correct them before carrying on to the next step.

#. Reconfigure the |chef analytics| server:

   .. code-block:: bash

      $ opscode-analytics-ctl reconfigure



Install |chef analytics| on frontend servers:

#. For each frontend server, install the |chef analytics| package. For example on |ubuntu|:

   .. code-block:: bash

      $ dpkg -i opscode-analytics<version>.deb

#. Copy over the files in the ``/etc/opscode-analytics`` directory from the |chef server| to the backend |chef analytics| server.

#. Edit the ``opscode-analytics.rb`` file:

   .. code-block:: bash

      analytics_fqdn "<fe_fqdn>"
      topology "tier"
      server "<be_fqdn>",
        :ipaddress => "<be_ip>",
        :role => "backend",
        :bootstrap => true
      server "<fe_fqdn>",
        :ipaddress => "<fe_ip>",
        :role => "frontend"
      backend_vip "<be_fqdn>",
        :ipaddress => "<be_ip>"

#. Verify the configuration using the preflight check command:

   .. code-block:: bash

      $ opscode-analytics-ctl preflight-check

   If there are any errors in the preflight check, correct them before carrying on to the next step.

#. Reconfigure the |chef server|:

   .. code-block:: bash
      
      $ sudo chef-server-ctl reconfigure

