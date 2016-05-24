.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


#. On any node in the backend HA cluster, run the following command for each node in the frontend group:

   .. code-block:: bash

      $ chef-backend-ctl gen-server-config FQDN -f chef-server.rb.fqdn

   where ``FQDN`` is the |fqdn| for the frontend machine. The generated ``chef-server.rb`` file will contain all of the values necessary for any frontend |chef server| to connect to and bootstrap against the backend HA cluster.

#. On each frontend machine, install the ``chef-server-core`` package (version 12.4.0 or higher).
#. On each frontend machine, copy the generated ``chef-server.rb``.fqdn to ``/etc/opscode/chef-server.rb``.
#. On each frontend machine, with root permission, run the following command:

   .. code-block:: bash

      $ chef-server-ctl reconfigure
