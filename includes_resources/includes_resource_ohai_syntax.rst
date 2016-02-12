.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A |resource ohai| resource block reloads the |ohai| configuration on a node:

.. code-block:: ruby

   ohai 'reload' do
     action :reload
   end

The full syntax for all of the properties that are available to the |resource ohai| resource is:

.. code-block:: ruby

   ohai 'name' do
     name                       String
     notifies                   # see description
     plugin                     String
     provider                   Chef::Provider::Ohai
     subscribes                 # see description
     action                     Symbol # defaults to :reload if not specified
   end

where 

* ``ohai`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the |chef client| will take to bring the node into the desired state
* ``name``, ``plugin``,  and ``provider`` are properties of this resource, with the |ruby| type shown. |see attributes|
