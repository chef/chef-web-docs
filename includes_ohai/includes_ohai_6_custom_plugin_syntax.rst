.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The syntax for an |ohai| 6 plugin is as follows:

.. code-block:: ruby

   require_plugin 'plugin_name'
   provides 'attribute', 'attribute/subattribute'

   # start of Ruby code that defines the Ohai 6 plugin
   
     attribute my_data
   
   # end of Ruby code that defines the Ohai 6 plugin

where 

* ``require_plugin`` is used to extend one (or more) existing |ohai| 6 plugins; an often-used value for ``require_plugin`` is ``'#{os}::hostname'``
* Required. ``provides`` is a comma-separated list of one (or more) attributes that are defined by this plugin. This attribute will become an automatic attribute (i.e. ``node[:attribute]``) after it is collected by |ohai| at the start of the |chef client| run. An attribute can also be defined using an ``attribute/subattribute`` pattern
* ``my_data`` is  string (``a string value``) or an empty mash (``{ :setting_a => 'value_a', :setting_b => 'value_b' }``). This is used to define the data that should be collected by the plugin

For example, an |ohai| 6 plugin could be built to add additional ``ipaddrtype_iface`` network attributes to help make it semantically easier to retrieve addresses:

.. code-block:: ruby

   provides 'network'
   
   require_plugin 'hostname'
   require_plugin '#{os}::network'
   
   network['interfaces'].each do |iface, addrs|
   
   addrs['addresses'].each do |ip, params|
     network['ipaddress_#{iface}'] ||= ip if params['family'].eql?('inet')
     network['ipaddress6_#{iface}'] ||= ip if params['family'].eql?('inet6')
     network['macaddress_#{iface}'] ||= ip if params['family'].eql?('lladdr')
   end
   
   end
   
   network

and then |knife| can be used to show these values. For example:

.. code-block:: bash

   $ knife node show guineapig -a network

to return something similar to:

.. code-block:: bash

   network:
   ...
     ipaddress6_eth0:    fe80::20c:29ff:fe12:7adc
     ipaddress6_lo:      ::1
     ipaddress_eth0:     10.13.37.200
     ipaddress_lo:       127.0.0.1
     macaddress_eth0:    00:0c:29:12:7a:dc

