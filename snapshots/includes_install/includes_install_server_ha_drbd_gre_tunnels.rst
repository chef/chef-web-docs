.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. warning:: This option is sometimes necessary when the Chef server is configured for high availability using DRBD.

Occasionally, a GRE tunnel will be required to handle the VRRP traffic. To accomplish this, set the following in ``/var/opt/opscode/keepalived/bin/tunnel.sh`` on the back-end server that will be used for bootstrapping:

.. code-block:: bash

   #!/bin/sh
   ip tunnel add pc mode gre remote VRRP_IP_OF_PEER local MY_IP ttl 25
   ip link set pc up
   ip addr add 172.18.16.1 dev pc
   ip route add 172.18.16.0/24 dev pc

Replace ``VRRP_IP_OF_PEER`` with the IP address of the server on the other end of the tunnel, and ``MY_IP`` with the IP address of the server on which the script will be located.

The ``172.17.16.**`` network addresses used in the previous examples could be any unused reserved IP address space.

Set the following in ``/etc/opscode/chef-server.rb``:

.. code-block:: ruby

   backend_vip "192.168.141.108",
     :ipaddress => "192.168.141.108",
     :device => "eth0"

And set the Keepalived unicast addresses to the GRE tunnel addresses.
