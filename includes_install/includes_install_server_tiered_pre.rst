.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Before installing the |chef server| software, perform the following steps:

* The backend server must be accessible from each frontend server. A virtual IP address is created and managed by the |chef server|, but will also need to be added to the DNS so that all machines in the tiered configuration may access it.
* Persistent data on the backend |chef server| is primarily composed of cookbook files and directories. Separate disks should be dedicated entirely to storing this data prior to installing the |chef server|.
* Load-balancing should be used with frontend servers, along with a DNS entry for the virtual IP address used for load balancing. This virtual IP address is added to the |chef server rb| file as the ``api_fqdn``. 
* All required ports must be open. See the Firewalls section (below) for the list of ports. All connections to and from the |chef server| are accomplished via TCP. Refer to the operating system's manual or your systems administrators for instructions on how to configure to ports, if necessary.
* The hostname for the |chef server| must be an |fqdn|, including the domain suffix, and must be resolvable by the backend and frontend servers. See `Hostnames, FQDNs <https://docs.chef.io/install_server_pre.html#hostnames>`_ for more information.
* ``chef-server-ctl reconfigure`` will not bind the ``backend_vip`` to the backend server. The easiest thing to do is just define ``backend_vip`` as the already configured main IP address of the backend system. If you need to use an additional address, it will need to be configured and bound on the system before ``chef-server-ctl reconfigure`` is run.
