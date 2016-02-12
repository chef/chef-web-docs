.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

The environment that is used when testing |vagrant| with upstream cookbooks and the reference |chef repo| is shown below. It defines the network and database settings that are used with |openstack|. The networks will be used in the libraries provided by the ``osops-utils`` cookbook. The following example shows a FlatDHCP with two physical networks.

.. code-block:: ruby

   name 'vagrant'

   override_attributes(
     'mysql' => {
       'allow_remote_root' => true,
       'root_network_acl' => '%'
     },
     'openstack' => {
       'developer_mode' => true,
       'identity' => {
         'catalog' => {
           'backend' => 'templated'
         },
       },
       'image' => {
         'image_upload' => true,
         'upload_images' => ['cirros'],
         'upload_image' => {
           'cirros' => 'https://launchpad.net/cirros/trunk/0.3.0/+download/cirros-0.3.0-x86_64-disk.img'
         },
         'identity_service_chef_role' => 'allinone-compute'
       },
       'block-storage' => {
         'keystone_service_chef_role' => 'allinone-compute'
       },
       'dashboard' => {
         'keystone_service_chef_role' => 'allinone-compute'
       },
       'network' => {
         'rabbit_server_chef_role' => 'allinone-compute'
       },
       'compute' => {
         'identity_service_chef_role' => 'allinone-compute',
         'network' => {
           'fixed_range' => '192.168.100.0/24',
           'public_interface' => 'eth2'
         },
         'config' => {
           'ram_allocation_ratio' => 5.0
         },
         'libvirt' => {
           'virt_type' => 'qemu'
         },
         'networks' => [
           {
             'label' => 'public',
             'ipv4_cidr' => '192.168.100.0/24',
             'num_networks' => '1',
             'network_size' => '255',
             'bridge' => 'br100',
             'bridge_dev' => 'eth2',
             'dns1' => '8.8.8.8',
             'dns2' => '8.8.4.4'
           }
         ]
       }
     }
   )
