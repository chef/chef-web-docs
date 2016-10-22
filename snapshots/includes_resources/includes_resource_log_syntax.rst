.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **log** resource block adds messages to the log file based on events that occur during the chef-client run:

.. code-block:: ruby

   log 'message' do
     message 'A message add to the log.'
     level :info
   end

The full syntax for all of the properties that are available to the **log** resource is:

.. code-block:: ruby

   log 'name' do
     level                      Symbol
     message                    String # defaults to 'name' if not specified
     notifies                   # see description
     provider                   Chef::Provider::ChefLog
     subscribes                 # see description
     action                     Symbol # defaults to :write if not specified
   end

where

* ``log`` is the resource
* ``name`` is the name of the resource block
* ``message`` is the log message to write
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``level``, ``message``, and ``provider`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
