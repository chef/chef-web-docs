.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

.. note:: The following manual steps assume that |runit| is the service manager for the |push jobs| daemon.

To set up the |push jobs| client manually:

#. Download the package from https://downloads.chef.io/push-jobs-client/.
#. Create a ``push-jobs-client.rb`` file in the ``/etc/chef/`` directory with contents similar to:

   .. code-block:: ruby

      chef_server_url   'https://chef.myorg.chefdemo.net/organizations/myorg'
      node_name         'builder1.myorg.chefdemo.net'
      client_key        '/etc/chef/client.pem'
      trusted_certs_dir '/etc/chef/trusted_certs'
      verify_api_cert   true
      ssl_verify_mode   :verify_peer
      
      whitelist({
        'chef-client'  => 'chef-client',
        /^delivery-cmd (.+)$/=>"/var/opt/delivery/workspace/bin/delivery-cmd '\\1'"
      })
      
      # We're under runit, so don't output timestamp
      Mixlib::Log::Formatter.show_time = true

#. Create the required directories:

   .. code-block:: ruby

      mkdir -p /etc/sv/opscode-push-jobs-client/log/main
      mkdir -p /etc/sv/opscode-push-jobs-client/env
      mkdir -p /etc/sv/opscode-push-jobs-client/control
      mkdir -p /var/log/opscode-push-jobs-client
      
      touch /etc/sv/opscode-push-jobs-client/log/config
      ln -s /etc/sv/opscode-push-jobs-client/log/config /var/log/opscode-push-jobs-client/config

#. Create a script ``/etc/sv/opscode-push-jobs-client/run`` with ``755`` permissions:

   .. code-block:: ruby

      #!/bin/sh
      exec 2>&1
      exec /opt/push-jobs-client/bin/pushy-client -l info  -c /etc/chef/push-jobs-client.rb

#. Create a script ``/etc/sv/opscode-push-jobs-client/log/run`` with ``755`` permissions:

   .. code-block:: ruby

      #!/bin/sh
      exec svlogd -tt /var/log/opscode-push-jobs-client

#. Create a symlink in the ``init.d`` directory to ``sv``:

   .. code-block:: ruby

      ln -s /sbin/sv /etc/init.d/opscode-push-jobs-client

#. Create a symlink for |push jobs| in the service directory:

   .. code-block:: ruby

      ln -s /etc/sv/opscode-push-jobs-client /etc/service/opscode-push-jobs-client

#. Verify that the |push jobs| client is running as a daemon or as a service:

   .. code-block:: bash

      $ knife node status node_name

   for a specific node and:

   .. code-block:: bash

      $ knife node status

   for all nodes.
