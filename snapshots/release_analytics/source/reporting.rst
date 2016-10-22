.. THIS PAGE IS LOCATED AT THE /release/analytics/ PATH.

=====================================================
Reporting  
=====================================================

.. include:: ../../includes_reporting/includes_reporting.rst

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst

Requirements
=====================================================
.. include:: ../../includes_system_requirements/includes_system_requirements_reporting.rst

Reporting is configured as :doc:`a premium feature </install_reporting>` of the Chef server and requires acceptance of the `Chef MLSA <https://docs.chef.io/chef_license.html>`__ as part of the installation process, starting with version 1.6.0.

The Reporting Run
=====================================================
.. include:: ../../includes_reporting/includes_reporting_run.rst

Chef Manage, Reports
=====================================================
.. include:: ../../includes_manage/includes_manage.rst

When Reporting and Chef management console are both added to the Chef server, a user interface for Reporting is also available.

.. image:: ../../images/step_manage_webui_reports.png

Knife Reporting
=====================================================
The ``knife reporting`` subcommand is used by Reporting to report about chef-client runs across the organization.

.. note:: Review the list of `common options <https://docs.chef.io/knife_common_options.html>`_ available to this (and all) knife subcommands and plugins.

Install the Plugin
-----------------------------------------------------
To install the ``knife reporting`` plugin using RubyGems, run the following command:

.. code-block:: bash

   $ /opt/chef/embedded/bin/gem install knife-reporting

where ``/opt/chef/embedded/bin/`` is the path to the location where the chef-client expects knife plugins to be located. If the chef-client was installed using RubyGems, omit the path in the previous example.







runs list
-----------------------------------------------------
Use the ``runs list`` argument to return a list of chef-client runs by organization or by node.


Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This argument has the following syntax:

.. code-block:: bash

   $ knife runs list NODE_NAME


Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
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

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
**View all chef-client runs for an organization**

To return a list of chef-client runs by organization (i.e. "every chef-client run that took place across every single node in the organization"), run the following command:

.. code-block:: bash

   $ knife runs list

**View all chef-client runs for a single node**

To return a list of chef-client runs that occurred for a node, run the following command:

.. code-block:: bash

   $ knife runs list node_name

where ``node_name`` is the name of a node.

**View a specific chef-client run**

To return a list of chef-client runs that occurred for a specific node, run the following command:

.. code-block:: bash

   $ knife runs list node_name 30077269-59d0-4283-81f6-8d23cbed3a7a

where ``node_name`` is the name of a node.

runs show
-----------------------------------------------------
Use the ``runs show`` argument to return the details for a chef-client run (by run identifier).

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This argument has the following syntax:

.. code-block:: bash

   $ knife runs show RUN_ID

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This argument has the following options:

``RUN_ID``
   The identifier for a chef-client run.


Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
**Show runs by run identifier**

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

state_attrs Method
=====================================================
.. include:: ../../includes_dsl_resource/includes_dsl_resource_method_state_attrs.rst

Configuration Settings
=====================================================
Reporting relies on two settings in the client.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``enable_reporting``
     - Cause the chef-client to send data to the Chef server for use with Reporting. For example:

       .. code-block:: ruby

          enable_reporting true
   * - ``enable_reporting_url_fatals``
     - Cause the chef-client run to fail when Reporting data cannot be sent to the Chef server (for any reason). For example:

       .. code-block:: ruby

          enable_reporting_url_fatals false



Reporting API
=====================================================
The Reporting API is a REST API that provides access to Reporting data that is collected during a chef-client run. Reporting data is collected only for nodes that have permission to publish Reporting data to the Chef server and only for organizations that have Reporting enabled.

Requirements
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_requirements.rst

Authentication Headers
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_headers.rst

Header Format
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_format.rst

Required Headers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following authentication headers are required:

.. list-table::
   :widths: 130 400
   :header-rows: 1

   * - Feature
     - Description
   * - ``Accept``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_accept.rst
   * - ``Content-Type``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_content_type.rst
   * - ``Host``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_host.rst
   * - ``X-Chef-Version``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_x_chef_version.rst
   * - ``X-Ops-Authorization-N``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_x_ops_authorization.rst
   * - ``X-Ops-Content-Hash``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_x_ops_content_hash.rst
   * - ``X-Ops-Reporting-Protocol-Version``
     - Use to specify the protocol version for the Reporting API. This header must be set to ``0.1.0``.
       
       * A request to the Chef server API that does not include this header and the correct value will return a 404 response code.
       * A request to the Chef server API that includes this header with an incorrect value will return a 406 reponse code.
       
       If the protocol version is incorrect (or unspecified), the chef-client run will proceed normally, but Reporting data will not be collected for that chef-client run unless the ``enable_reporting_url_fatals`` setting is ``true`` in the client.rb file for that node.
   * - ``X-Ops-Sign``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_x_ops_sign.rst
   * - ``X-Ops-Timestamp``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_x_ops_timestamp.rst
   * - ``X-Ops-UserId``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_x_ops_userid.rst

Example
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_example.rst

Global Endpoints
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoints_global.rst

/reports/status
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``/reports/status`` endpoint has the following methods: ``GET``.

GET
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The ``GET`` method is used to return the status of the system components used by Reporting. 

This method does not have any parameters.

**Request**

.. code-block:: xml

   GET /reports/status

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "rest_api" : "online",
     "sql_db" : "online",
     "index" : "online"
   }

where ``index`` is the Chef server search index. If the system component is not online, the response will return ``offline``.

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``404``
     - Not found. The requested object does not exist.
   * - ``406``
     - Invalid request. The protocol version is incorrect.

Organization Endpoints
-----------------------------------------------------
Each organization-specific authentication request must include ``/organizations/ORG_NAME`` as part of the name for the endpoint. For example, the full endpoint for getting the details for a specific reporting run identifier for a node:

.. code-block:: html

   GET /organizations/ORG_NAME/reports/nodes/NODE/runs/RUNID

where ``ORG_NAME`` is the name of the organization, ``NODE`` is the name of the node, and ``RUNID`` is the reporting run identifier.

/reports/nodes/NODE/runs
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``/reports/nodes/NODE/runs`` endpoint has the following methods: ``GET`` and ``POST``.

GET
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The ``GET`` method is used to return Reporting data for a chef-client run. 

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/ORG/reports/nodes/NODE/runs

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "node_name" : "pkd01234567",
     "run_id" : "550e4500-e22b-4ad4-a716-446659876500",
     "start_time" : "2014-11-14T23:33:34Z"
     "status" : "started"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``404``
     - Not found. The requested object does not exist.
   * - ``406``
     - Invalid request. The protocol version is incorrect.

/reports/nodes/NODE/runs/RUNID/RESID
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``/reports/nodes/NODE/runs/RUNID/RESID`` endpoint has the following methods: ``GET``.

GET
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The ``GET`` method is used to return a list of what changed during the chef-client run for the specified resource. 

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/ORG/reports/nodes/NODE/runs/RUNID/RESID

**Response**

The response is similar to:

.. code-block:: none

   {
     resource_detail :
     {
       "content_delta" : string
     }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``404``
     - Not found. The requested object does not exist.
   * - ``406``
     - Invalid request. The protocol version is incorrect.

/reports/nodes/NODE/runs/RUNID
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``/reports/nodes/NODE/runs/RUNID`` endpoint has the following methods: ``GET`` and ``POST``.

GET
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The ``GET`` method is used to return a list of resources for a given Reporting run identifier. 

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``detail``
     - Optional. When ``true``, include the ``run_detail`` JSON object in the output. Default value: ``false``.
   * - ``rows``
     - Optional. The number of resources to return. Default value: ``10``.
   * - ``start``
     - Optional. The row at which the results will start. Default value: ``0``.

**Request**

.. code-block:: none

   GET /organizations/ORG/reports/nodes/NODE/runs/RUNID

**Response**

The response is similar to:

.. code-block:: javascript

   {
     run_resources :  [
       {
         "uri" : uri,
         "cookbook_name" : string,
         "cookbook_version" : string,
         "duration" : numeric string - milliseconds,
         "id" : string,
         "type" : string,
         "name" : string,
         "result" : string,
         "initial_state" : json-object,
         "final_state" : json-object,
       }
     ],
     run_detail :
       {
         "node_name" : string,
         "updated_res_count" : integer,
         "total_res_count" : integer,
         "run_list" : string ??? TODO: Verify this is correct
         "start_time" : timestamp
         "end_time" : timestamp
         "data" : { 0..1 exception-record },
         "status"
       }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``404``
     - Not found. The requested object does not exist.
   * - ``406``
     - Invalid request. The protocol version is incorrect.

/reports/org/runs
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``/reports/org/runs`` endpoint has the following methods: ``GET``.

GET
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The ``GET`` method is used to return information about chef-client runs for all nodes in the specified organization. 

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``from``
     - Optional. Use to specify the time before which node data will not be returned. Use with ``until`` to define a range.
   * - ``rows``
     - Optional. The number of resources to return. Default value: ``10``.
   * - ``start``
     - Optional. The row at which the results will start. Default value: ``0``.
   * - ``status``
     - Optional. Use to specify a status code. When a status code is provided, only nodes with that status will be returned. When a status code is not provided, all nodes will be returned. Possible values: ``aborted``, ``failure``, or ``success``.
   * - ``until``
     - Optional. Use to specify the time after which node data will not be returned. Use with ``until`` to define a range.

**Request**

.. code-block:: xml

   GET /organizations/ORG/reports/org/runs

**Response**

The response is similar to:

.. code-block:: javascript

   {
     
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``404``
     - Not found. The requested object does not exist.
   * - ``406``
     - Invalid request. The protocol version is incorrect.

/reports/runs/counts
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``/reports/runs/counts`` endpoint has the following methods: ``GET``.

GET
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The ``GET`` method is used to return the frequency of chef-client runs, per-minute, per-hour, per-day, or per-week.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``granularity``
     - Required. The length of time for which chef-client run counts are returned. Possible values: ``hour``, ``minute``, ``day``, or ``week``.

**Request**

.. code-block:: xml

   GET /organizations/ORG/reports/runs/counts

**Response**

The response is similar to:

.. code-block:: javascript

   {
   
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``404``
     - Not found. The requested object does not exist.
   * - ``406``
     - Invalid request. The protocol version is incorrect.

/reports/runs/durations
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``/reports/runs/durations`` endpoint has the following methods: ``GET``.

GET
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The ``GET`` method is used to return the frequency of chef-client runs that occured within a specified range.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``from``
     - Optional. Use to specify the time before which node data will not be returned. Use with ``until`` to define a range.
   * - ``until``
     - Optional. Use to specify the time after which node data will not be returned. Use with ``until`` to define a range.

**Request**

.. code-block:: xml

   GET /organizations/ORG/reports/runs/durations

**Response**

The response is similar to:

.. code-block:: javascript

   {
   
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``404``
     - Not found. The requested object does not exist.
   * - ``406``
     - Invalid request. The protocol version is incorrect.
