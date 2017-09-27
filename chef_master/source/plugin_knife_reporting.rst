=====================================================
knife reporting
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/plugin_knife_reporting.rst>`__

.. tag reporting_legacy

.. note:: This documentation is meant to support existing Chef customers using Reporting.

          Are you a new Chef customer, or looking to gain better insight into your fleet? Take advantage of :doc:`Chef Automate </chef_automate>`. You'll get a graphical interface and query language that gives you insight into operational, compliance, and workflow events. You can `download Chef Automate here <https://downloads.chef.io/automate/>`__.

.. end_tag

.. tag reporting_summary

Use Reporting to keep track of what happens during the execution of chef-client runs across all of the machines that are under management by Chef. Reports can be generated for the entire organization and they can be generated for specific nodes.

Reporting data is collected during the chef-client run and the results are posted to the Chef server at the end of the chef-client run at the same time the node object is uploaded to the Chef server.

.. end_tag

.. tag plugin_knife_reporting_summary

The ``knife reporting`` subcommand is used by Reporting to report about chef-client runs across the organization.

.. end_tag

.. note:: Review the list of :doc:`common options </knife_options>` available to this (and all) knife subcommands and plugins.

Install this plugin
=====================================================
.. tag plugin_knife_reporting_install_rubygem

To install the ``knife reporting`` plugin using RubyGems, run the following command:

.. code-block:: bash

   $ /opt/chef/embedded/bin/gem install knife-reporting

where ``/opt/chef/embedded/bin/`` is the path to the location where the chef-client expects knife plugins to be located. If the chef-client was installed using RubyGems, omit the path in the previous example.

.. end_tag

runs list
=====================================================
.. tag plugin_knife_reporting_runs_list

Use the ``runs list`` argument to return a list of chef-client runs by organization or by node.

.. end_tag

Syntax
-----------------------------------------------------
.. tag plugin_knife_reporting_runs_list_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife runs list NODE_NAME

.. end_tag

Options
-----------------------------------------------------
.. tag plugin_knife_reporting_runs_list_options

This argument has the following options:

``-e MM-DD-YYYY``, ``--endtime MM-DD-YYYY``
   Find runs with an end time less than or equal to the specified date. This option must be used in conjunction with ``--starttime`` and may define up to a 90-day time period.

``RUN_ID``
   Required. The identifier for a chef-client run.

``-r N``, ``--rows N``
   The number of rows to be returned.

``-s MM-DD-YYYY``, ``--starttime MM-DD-YYYY``
   Find runs with a start time greater than or equal to the specified date. This option must be used in conjunction with ``--endtime`` and may define up to a 90-day time period.

``-u``, ``--unixtimestamps``
   Show start and end times as UNIX timestamps. This option may be used when the ``--endtime`` and ``--starttime`` options are used.

.. end_tag

Examples
-----------------------------------------------------
**View all chef-client runs for an organization**

.. tag plugin_knife_reporting_runs_list_by_organization

To return a list of chef-client runs by organization (i.e. "every chef-client run that took place across every single node in the organization"), run the following command:

.. code-block:: bash

   $ knife runs list

.. end_tag

**View all chef-client runs for a single node**

.. tag plugin_knife_reporting_runs_list_by_node

To return a list of chef-client runs that occurred for a node, run the following command:

.. code-block:: bash

   $ knife runs list node_name

where ``node_name`` is the name of a node.

.. end_tag

**View a specific chef-client run**

.. tag plugin_knife_reporting_runs_list_by_run_id

To return a list of chef-client runs that occurred for a specific node, run the following command:

.. code-block:: bash

   $ knife runs list node_name 30077269-59d0-4283-81f6-8d23cbed3a7a

where ``node_name`` is the name of a node.

.. end_tag

runs show
=====================================================
.. tag plugin_knife_reporting_runs_show

Use the ``runs show`` argument to return the details for a chef-client run (by run identifier).

.. end_tag

Syntax
-----------------------------------------------------
.. tag plugin_knife_reporting_runs_show_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife runs show RUN_ID

.. end_tag

Options
-----------------------------------------------------
.. tag plugin_knife_reporting_runs_show_options

This argument has the following options:

``RUN_ID``
   The identifier for a chef-client run.

.. end_tag

Examples
-----------------------------------------------------
**Show runs by run identifier**

.. tag plugin_knife_reporting_runs_show_by_run_id

To return details about a specific chef-client run, run the following command:

.. code-block:: bash

   $ knife runs show c40csdcf2-5007-433c-95570-8e0c7e55f496

For a chef-client run that succeeded, the command will return something similar to:

.. code-block:: bash

   $ run_detail:
       data:
         end_time:          2013-12-10T17:18:49Z
         node_name:         kitchen-vagrant
         run_id:            c40csdcf2-5007-433c-95570-8e0c7e55f496
         run_list:          ["recipe[createfile]"]
         start_time:        2013-12-10T17:18:49Z
         status:            success
         total_res_count:   1
         updated_res_count: 1
     run_resources:
       cookbook_name:    createfile
       cookbook_version: 0.0.0
       duration:         41
       final_state:
         checksum: f29bc64a9d3123454gfdsffdb3285f5bsdfsdf72414671e0ca3b2e0de
         group:    root
         mode:     0755
         owner:    root
       id:               /tmp/test
       initial_state:
         checksum:
         group:
         mode:
         owner:
       name:             /tmp/test
       result:           touch
       type:             file
       uri:              URI

For a chef-client run that failed (or had some type of error), the command will return something similar to:

.. code-block:: bash

   $ run_detail:
       data:
         exception:
           backtrace: ["/opt/chef/embedded/lib/ruby/1.9.3/net/http.rb:763:in 'initialize'",
                       "/opt/chef/embedded/lib/ruby/1.9.3/net/http.rb:763:in 'open'",
                       "/opt/chef/embedded/lib/ruby/1.9.3/net/http.rb:763:in 'block in connect'",
                       "/opt/chef/embedded/lib/ruby/1.9.3/timeout.rb:55:in 'timeout'",
                       "/opt/chef/embedded/lib/ruby/1.9.3/timeout.rb:100:in 'timeout'",
                       "/opt/chef/embedded/lib/ruby/1.9.3/net/http.rb:763:in 'connect'",
                       "/opt/chef/embedded/lib/ruby/1.9.3/net/http.rb:756:in 'do_start'",
                       ...
                       "/usr/bin/chef-client:23:in 'load'",
                       "/usr/bin/chef-client:23:in '<main>'"]
           class:       #<SocketError: Error connecting to URL - getaddrinfo: Temporary failure in name resolution>
           description:
             sections:
               Networking Error:: Error connecting to URL - getaddrinfo: Temporary failure in name resolution
                                  Your chef_server_url may be misconfigured, or the network could be down.
               Relevant Config Settings:: chef_server_url  "URL"
             title:    Error Syncing Cookbooks:
             message:     Error connecting to URL - getaddrinfo: Temporary failure in name resolution
             end_time:          2013-12-10T14:38:18Z
             node_name:         node_name
             run_id:            c40csdcf2-5007-433c-95570-8e0c7e55f496
             run_list:          ["recipe[createfile]"]
             start_time:        2013-12-10T14:37:37Z
             status:            failure
             total_res_count:   0
             updated_res_count: 0
     run_resources:

.. end_tag

