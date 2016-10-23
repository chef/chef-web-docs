.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``keepalived``:

``keepalived['dir']``
   The working directory. The default value is the recommended value. Default value: ``'/var/opt/opscode/keepalived'``.

``keepalived['enable']``
   Enable a service. Enable this setting for backend servers in high availability topologies. Default value: ``false``.

``keepalived['ipv6_on']``
   Enable Internet Protocol version 6 (IPv6) addresses. Default value: ``false``.

``keepalived['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``'/var/log/opscode/keepalived'``.

``keepalived['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``

``keepalived['service_posthooks']``
   The directory to which Keepalived is to send ``POST`` hooks. Default value:

   .. code-block:: ruby

      '{ 'rabbitmq' => '/opt/opscode/bin/wait-for-rabbit' }'


``keepalived['smtp_connect_timeout']``
   The amount of time (in seconds) to wait for a connection to an SMTP server. Default value: ``'30'``.

``keepalived['smtp_server']``
   The SMTP server to which a connection is made. Default value: ``'127.0.0.1'``.

``keepalived['vrrp_instance_advert_int']``
   The frequency (in seconds) at which the primary VRRP server is to advertise. Default value: ``'1'``.

``keepalived['vrrp_instance_interface']``
   The interface over which VRRP traffic is sent. Should be set to the name of the dedicated interface for Keepalived. Default value: ``'eth0'``.

``keepalived['vrrp_instance_ipaddress']``
   The virtual IP address to be managed. This is typically set by the ``backend_vip`` option. Default value: ``node['ipaddress']``.

``keepalived['vrrp_instance_ipaddress_dev']``
   The device to which the virtual IP address is added. Default value: ``'eth0'``. 

``keepalived['vrrp_instance_nopreempt']``
   Specify that a lower priority machine maintains the master role, even if a higher priority machine is available. (This setting configures the ``noprempt`` value in VRRP.) Default value: ``'true'``.

``keepalived['vrrp_instance_password']``
   The secret key for VRRP pairs. This value is generated randomly when the bootstrap server is installed and does not need to be set explicitly. Default value: ``'sneakybeaky'``.

``keepalived['vrrp_instance_preempt_delay']``
   The ``prempt_delay`` value for the VRRP instance. Default value: ``'30'``.

``keepalived['vrrp_instance_priority']``
   The priority for this server. By default, all servers have equal priority. The server with the lowest value will have the highest priority. Default value: ``'100'``.

``keepalived['vrrp_instance_state']``
   The state of the VRRP server. This value should be the same for both servers in the backend. Default value: ``'BACKUP'``.

``keepalived['vrrp_instance_virtual_router_id']``
   The virtual router identifier used by the Keepalived pair. This value should be unique within the multicast domain used for Keepalived. Default value: ``'1'``.

``keepalived['vrrp_sync_group']``
   The name of the VRRP synchronization group. Default value: ``'PC_GROUP'``.

``keepalived['vrrp_sync_instance']``
   The name of the VRRP synchronization instance. Default value: ``'PC_VI'``.

``keepalived['vrrp_unicast_bind']``
   The unicast cluster IP address to which Keepalived binds. To use multicast, leave this value undefined. This value is configured automatically based on settings in private-chef.rb. This setting should not be changed without first consulting a Chef support engineer. Default value: ``node['ipaddress']``.

``keepalived['vrrp_unicast_peer']``
   The unicast cluster IP address used by Keepalived to talk to its peer. To use multicast, leave this value undefined. This value is configured automatically based on settings in private-chef.rb. This setting should not be changed without first consulting a Chef support engineer. Default value: ``nil``.
