.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **ifconfig** resource block manages interfaces, such as a static IP address:

.. code-block:: ruby

   ifconfig '33.33.33.80' do
     device 'eth1'
   end

The full syntax for all of the properties that are available to the **ifconfig** resource is:

.. code-block:: ruby

   ifconfig 'name' do
     bcast                      String
     bootproto                  String
     device                     String
     hwaddr                     String
     inet_addr                  String
     mask                       String
     metric                     String
     mtu                        String
     network                    String
     notifies                   # see description
     onboot                     String
     onparent                   String
     provider                   Chef::Provider::Ifconfig
     subscribes                 # see description
     target                     String # defaults to 'name' if not specified
     action                     Symbol # defaults to :create if not specified
   end

where 

* ``ifconfig`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``bcast``, ``bootproto``, ``device``, ``hwaddr``, ``inet_addr``, ``mask``, ``metric``, ``mtu``, ``network``, ``onboot``, ``onparent``, ``provider``,  and ``target`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
