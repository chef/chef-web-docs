.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows how to configure network interfaces on multiple |ubuntu| nodes, starting with putting ``/etc/network/interfaces`` under the management of the |chef client| by using the |resource template| resource:

.. code-block:: ruby

   template '/etc/network/interfaces' do
     action :create
     source 'interfaces.erb'
   end

The copy the file at ``/etc/network/interfaces`` into the ``/templates/default`` directory; name that file ``interfaces.erb``. And then from there, data can be rendered into that template. Update the resource:

.. code-block:: ruby

   template '/etc/network/interfaces' do
     action :create
     source 'interfaces.erb'
     variables()
   end
