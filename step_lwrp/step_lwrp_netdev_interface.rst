.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To use the ``netdev_interface`` lightweight resource:

.. code-block:: ruby

   netdev_interface "ge-0/0/0" do
     description "description"
     speed "1g"
     duplex "full"
     action :create
   end
