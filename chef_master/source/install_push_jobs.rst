=====================================================
Install Chef Push Jobs
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_push_jobs.rst>`__

Chef push jobs is installed to the following locations:

* The same machine as the Chef server (version 12.6 or higher)
* One (or more) nodes on which the chef-client (version 12 or higher) is installed
* At least one management workstation

Install the Server
=====================================================
Use the `chef-server-ctl install </ctl_chef_server.html#install>`_ command to add Chef push jobs.

Install the Client
=====================================================
To set up the Chef push jobs client:

#. Add the **push-jobs** cookbook to the run-list for each of the nodes on which Chef push jobs is to be configured.
#. Add the following default attributes on all nodes that are managed by Chef push jobs:

   .. code-block:: javascript

      "push_jobs": {
        "package_url": "<package_url>",
        "package_checksum": "<checksum>"
      }

#. Run the chef-client to configure Chef push jobs
#. Verify that the Chef push jobs client is running as a daemon or as a service:

   .. code-block:: bash

      $ knife node status node_name

   for a specific node and:

   .. code-block:: bash

      $ knife node status

   for all nodes.

Install the Workstation
=====================================================
To set up the Chef push jobs workstation, install the ``knife push jobs`` plugin by running the following command on a workstation:

.. code-block:: bash

   chef gem install knife-push

Once installed, the following subcommands will be available: ``knife job list``, ``knife job start``, ``knife job output``, ``knife job status``, and ``knife node status``.

**push-jobs** Cookbook
-----------------------------------------------------
The **push-jobs** cookbook at https://github.com/chef-cookbooks/push-jobs is used by the chef-client to configure Chef push jobs as a client on a target node. This cookbook is also used to define the whitelist, which is a list of commands that Chef push jobs may execute when it runs. A command that is not in the whitelist will not be executed by Chef push jobs. The **push-jobs** cookbook should be managed like any other cookbook, i.e. "downloaded from GitHub, managed using version source control, and uploaded to the Chef server". To manage nodes using Chef push jobs, add the **push-jobs** cookbook to the run-list for each node that will be managed using Chef push jobs.

The whitelist is defined using the ``node['push_jobs']['whitelist']`` attribute located in the default attributes file:

.. code-block:: ruby

   default['push_jobs']['whitelist']   = {
        "job_name" => "command",
        "job_name" => "command",
        "chef-client" => "chef-client" }

where ``job_name`` represents each of the jobs that are defined in the whitelist and ``command`` is the command line that will be run on the target node. The ``chef-client`` job is the only job in the whitelist after the initial installation of Chef push jobs.

After the whitelist is defined, add the jobs to the client.rb file on each node that will be managed by Chef push jobs:

.. code-block:: ruby

   whitelist({ "job_name" => "command",
               "job_name" => "command",
               "chef-client" => "chef-client"
             })

For example:

.. code-block:: ruby

   {
     "chef-client": "sudo chef-client",
     "chef_client_with_special_run_list": "sudo chef-client -o recipe[special_recipe]",
     "sv restart apache"
   }

By default, any attempt to run a Chef push jobs command other than ``chef-client`` will be rejected with ``nack``. For example:

.. code-block:: bash

   $ knife job start some_command my_node

will return something similar to:

.. code-block:: bash

   Started.  Job ID: 67079444838d123456f0c1ea614c1fcaa0f
   Failed.
   command:     some_command
   created_at:  Tue, 29 Oct 2013 21:22:59 GMT
   id:          67079444425fdcdd0c1ea614c1fcaa0f
   nodes:
     nacked: my_node
   run_timeout: 3600
   status:      nacked
   updated_at:  Tue, 29 Oct 2013 21:23:04 GMT

To add commands, simply append them to the whitelist for roles, environments, and nodes. For example, to set all of the nodes in the ``dev`` environment to accept a Chef push jobs command to restart Apache, run the following command:

.. code-block:: bash

   $ knife edit environments/dev.json

and then update the default attributes to include something like:

.. code-block:: javascript

   {
     "name": "dev",
     "description": "The development environment",
     "default_attributes": {
       "push_jobs": {
         "whitelist": {
           "chef-client": "chef-client",
           "chef_client_with_special_run_list": "sudo chef-client -o recipe[special_recipe]",
           "restart_apache": "sv restart apache"
         }
       }
     }
   }

after which the following command can be run against nodes in the ``dev`` environment to restart Apache:

.. code-block:: bash

   $ knife job start restart_apache NODE1 NODE2 ...

where ``NODE1 NODE2 ...`` defines a list of individual nodes against which that command is run.

Chef Push Jobs Groups
=====================================================
.. tag push_jobs_summary

Chef push jobs is an extension of the Chef server that allows jobs to be run against nodes independently of a chef-client run. A job is an action or a command to be executed against a subset of nodes; the nodes against which a job is run are determined by the results of a search query made to the Chef server.

Chef push jobs uses the Chef server API and a Ruby client to initiate all connections to the Chef server. Connections use the same authentication and authorization model as any other request made to the Chef server. A knife plugin is used to initiate job creation and job tracking.

.. end_tag

.. note:: The Chef server uses role-based access control to define the `organizations, groups, and users </server_orgs.html>`__, including those needed by Chef push jobs.

.. tag server_rbac_groups_push_jobs

It is possible to initiate jobs from the chef-client, such as from within a recipe based on an action to be determined as the recipe runs. For a chef-client to be able to create, initiate, or read jobs, the chef-client on which Chef push jobs is configured must belong to one (or both) of the following groups:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Group
     - Description
   * - ``pushy_job_readers``
     - Use to view the status of jobs.
   * - ``pushy_job_writers``
     - Use to create and initiate jobs.

These groups do not exist by default, even after Chef push jobs has been installed to the Chef server. If these groups are not created, only members of the ``admin`` security group will be able to create, initiate, and view jobs.

.. end_tag

