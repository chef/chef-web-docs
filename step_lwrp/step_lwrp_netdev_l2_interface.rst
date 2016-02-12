.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To use the ``netdev_l2_interface`` lightweight resource:

.. code-block:: ruby

   netdev_l2_interface "ge-0/0/0" do
     description "description"
     tagged_vlans %w{ foobar }
     vlan_tagging true
     action :create
   end
