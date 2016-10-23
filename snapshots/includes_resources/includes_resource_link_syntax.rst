.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **link** resource block creates symbolic or hard links. For example, to create a hard link from ``/tmp/file`` to ``/etc/file``:

.. code-block:: ruby

   link '/tmp/file' do
     to '/etc/file'
     link_type :hard
   end

Because the default value for ``link_type`` is symbolic, and because properties that are not specified in the resource block will be assigned their default values, the following example creates a symbolic link:

.. code-block:: ruby

   link '/tmp/file' do
     to '/etc/file'
   end

The full syntax for all of the properties that are available to the **link** resource is:

.. code-block:: ruby

   link 'name' do
     group                      Integer, String
     link_type                  Symbol
     mode                       Integer, String
     notifies                   # see description
     owner                      Integer, String
     provider                   Chef::Provider::Link
     subscribes                 # see description
     target_file                String # defaults to 'name' if not specified
     to                         String
     action                     Symbol # defaults to :create if not specified
   end

where 

* ``link`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``group``, ``link_type``, ``mode``, ``owner``, ``provider``, ``target_file``, and ``to`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
