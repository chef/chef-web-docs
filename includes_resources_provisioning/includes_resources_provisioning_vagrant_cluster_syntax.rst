.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``vagrant_cluster`` resource block typically declares a cluster to be created or deleted. For example:

.. code-block:: ruby

.. code-block:: ruby

   vagrant_cluster '/path/to/cluster' do
     action :delete
   end

The full syntax for all of the properties that are available to the ``vagrant_cluster`` resource is:

.. code-block:: ruby

   vagrant_cluster 'name' do
     path                    String
   end

where 

* ``vagrant_cluster`` is the resource
* ``name`` is the name of the resource block and also the name of a cluster
* ``path`` is a property of this resource, with the |ruby| type shown. |see attributes|
