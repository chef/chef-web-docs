.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A whitelist is a list of jobs and commands that are used by Chef push jobs. A whitelist is saved as an attribute in the **push-jobs** cookbook. For example:

.. code-block:: ruby

   default['push_jobs']['whitelist'] = {
     'job_name' => 'command',
   }

The whitelist is accessed from a recipe using the ``node['push_jobs']['whitelist]`` attribute. For example:

.. code-block:: ruby

   template 'name' do
     source 'name'
     ...
     variables(:whitelist => node['push_jobs']['whitelist'])
   end

Use the ``knife exec`` subcommand to add a job to the whitelist. For example:

.. code-block:: bash

   $ knife exec -E 'nodes.transform("name:A_NODE_NAME") do |n|
       n.set["push_jobs"]["whitelist"]["ntpdate"] = "ntpdate -u time"
     end'

where ``["ntpdate"] = "ntpdate -u time"`` is added to the whitelist:

.. code-block:: ruby

   default['push_jobs']['whitelist'] = {
     "ntpdate" => "ntpdate -u time",
   }
