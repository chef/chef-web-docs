.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To use the ``netdev_vlan`` lightweight resource:

.. code-block:: ruby

   netdev_vlan "name" do
     vlan_id 2
     description "description"
     action :create
   end
