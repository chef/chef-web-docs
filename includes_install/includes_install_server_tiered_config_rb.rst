.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The |chef server rb| file that is located in the ``/etc/opscode/`` directory describes the topology of the tiered configuration. On the backend server, create a file named |chef server rb| and save it in the ``/etc/opscode/`` directory.

Add the following settings to the |chef server rb| file:

#. Define the topology type:

   .. code-block:: ruby

      topology "tier"

#. Define the backend server:

   .. code-block:: ruby

      server "FQDN",
        :ipaddress => "IP_ADDRESS",
        :role => "backend",
        :bootstrap => true

   Replace ``FQDN`` with the |fqdn| of the server and ``IP_ADDRESS`` with the IP address of the server. The role is a backend server is ``"backend"``.

#. Define the backend virtual IP address:

   .. code-block:: ruby

      backend_vip "FQDN",
        :ipaddress => "IP_ADDRESS",
        :device => "eth0"

   Replace ``FQDN`` with the |fqdn| of the server. Replace ``IP_ADDRESS`` with the virtual IP address of the server. The ``:device`` parameter should be the ethernet interface to which the virtual IP address will bind. This is typically the public interface of the server. In a typical tiered install, the config here could also be just the main |fqdn| and IP address that are already configured for the backend. Running ``chef-server-ctl reconfigure`` will not bind the ``backend_vip`` address to an interface, this must be done on startup of the machine. 

#. Define each frontend server:

   .. code-block:: ruby

      server "FQDN",
        :ipaddress => "IP_ADDRESS",
        :role => "frontend"

   Replace ``FQDN`` with the |fqdn| of the frontend server. Replace ``IP_ADDRESS`` with the IP address of the frontend server. Set ``:role`` to ``"frontend"``.

   Add separate entry in the |chef server rb| file for each frontend server.

#. Define the API |fqdn|:

   .. code-block:: ruby

      api_fqdn "FQDN"

   Replace ``FQDN`` with the |fqdn| of the load balanced virtual IP address, which should be equal to the |fqdn| for the service URI that is used by the |chef server|.

#. .. include:: ../../step_install/step_install_chef_server_reconfigure.rst
