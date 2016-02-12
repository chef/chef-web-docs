.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. This topic should NOT be included in any build after chef-client 11-4 (inclusive).


.. warning:: Use sparingly. Most resources are idempotent by design and do not require using any of the approaches that are discussed below.

This page describes how to construct a first-run resource---a resource that only performs an action on the first |chef client| run---that does nothing on all subsequent |chef client| runs.

.. note:: Some resources, by their nature, are not idempotent. For example, the |resource execute| and |resource script|-based resources are not idempotent because the commands that are executed by these resources are typically unique to the environment in which they are run. Most of the time, these resources can be made idempotent by `inspecting the state of the node using guards <https://docs.chef.io/resource_common.html#guards>`_---``not_if`` and ``only_if``---and then defining the conditions necessary to ensure idempotence for that resource block.

However, it may be difficult (or even impossible) to correctly inspect the state of the node. Or it may be that a command should not be run again, even if the state of the node is incorrect. 

One situation where a first-run resource is useful is to prevent a command from being run a second time. To create this type of first-run resource, set a node attribute after sucessfully completing a task, and then testing for the presence of that attribute. For example:

.. code-block:: ruby

   execute 'some_command' do
     command 'command to run once'
     notifies :create, 'ruby_block[some_command_run_flag]', :immediately
     not_if { node.attribute?('attribute') }
   end
   
   ruby_block 'some_command_run_flag' do
     block do
       node.set['attribute'] = true
       node.save
     end
     action :nothing
   end

where:

* The ``command`` to be run (or not run) is defined by the |resource execute| resource
* The |resource ruby_block| resource is notified by the |resource execute| resource when it runs
* The |resource ruby_block| resource sets an attribute (to ``true``) when it is notified
* The  ``not_if`` guard in the |resource execute| resource block tests for the presence of this attribute; when present, the |resource execute| resource block will not run

Some other benefits from this approach to defining first-run resources include searchable flags:

.. code-block:: bash

   $ knife search node "some_command_complete:*"

which can then be unset later using |knife|:

.. code-block:: bash

   $ knife exec -E 'nodes.all { |n| n.delete("some_command_complete"); n.save() }'
