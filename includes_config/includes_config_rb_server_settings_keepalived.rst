.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``keepalived``:

``keepalived['dir']``
   |directory generic| |default_value_recommended| Default value: ``'/var/opt/opscode/keepalived'``.

``keepalived['enable']``
   |enable service| |ha backend| Default value: ``false``.

``keepalived['ipv6_on']``
   |enable ipv6| Default value: ``false``.

``keepalived['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``'/var/log/opscode/keepalived'``.

``keepalived['log_rotation']``
   |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``

``keepalived['service_posthooks']``
   |directory keepalive_post_hooks| Default value:

   .. code-block:: ruby

      '{ 'rabbitmq' => '/opt/opscode/bin/wait-for-rabbit' }'


``keepalived['smtp_connect_timeout']``
   |timeout smtp_connect| Default value: ``'30'``.

``keepalived['smtp_server']``
   |smtp server| Default value: ``'127.0.0.1'``.

``keepalived['vrrp_instance_advert_int']``
   |vrrp_instance_advert| Default value: ``'1'``.

``keepalived['vrrp_instance_interface']``
   |vrrp_instance_interface| Should be set to the name of the dedicated interface for |keepalived|. Default value: ``'eth0'``.

``keepalived['vrrp_instance_ipaddress']``
   |vrrp_instance_ipaddress| This is typically set by the ``backend_vip`` option. Default value: ``node['ipaddress']``.

``keepalived['vrrp_instance_ipaddress_dev']``
   |vrrp_instance_ipaddress_device| Default value: ``'eth0'``. 

``keepalived['vrrp_instance_nopreempt']``
   |vrrp_instance_nopreempt| (This setting configures the ``noprempt`` value in |vrrp|.) Default value: ``'true'``.

``keepalived['vrrp_instance_password']``
   |vrrp_instance_password| This value is generated randomly when the bootstrap server is installed and does not need to be set explicitly. Default value: ``'sneakybeaky'``.

``keepalived['vrrp_instance_preempt_delay']``
   |vrrp_instance_prempt_delay| Default value: ``'30'``.

``keepalived['vrrp_instance_priority']``
   |vrrp_instance_priority| By default, all servers have equal priority. The server with the lowest value will have the highest priority. Default value: ``'100'``.

``keepalived['vrrp_instance_state']``
   |vrrp_instance_state| This value should be the same for both servers in the backend. Default value: ``'BACKUP'``.

``keepalived['vrrp_instance_virtual_router_id']``
   |vrrp_instance_virtual_router_id| This value should be unique within the multicast domain used for |keepalived|. Default value: ``'1'``.

``keepalived['vrrp_sync_group']``
   |name vrrp_sync_group| Default value: ``'PC_GROUP'``.

``keepalived['vrrp_sync_instance']``
   |name vrrp_sync_instance| Default value: ``'PC_VI'``.

``keepalived['vrrp_unicast_bind']``
   |vrrp_unicast_bind| To use multicast, leave this value undefined. This value is configured automatically based on settings in |private chef rb|. |opscode_support| Default value: ``node['ipaddress']``.

``keepalived['vrrp_unicast_peer']``
   |vrrp_unicast_peer| To use multicast, leave this value undefined. This value is configured automatically based on settings in |private chef rb|. |opscode_support| Default value: ``nil``.
