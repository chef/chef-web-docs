.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following fields are available for the ``run_converge`` message type:

.. list-table::
   :widths: 120 60 320
   :header-rows: 1

   * - Field
     - Type
     - Description
   * - ``chef_server_fqdn``
     - string
     - The |fqdn| for the |chef server| against which the instance is running. For example: ``'api.chef.io'``.
   * - ``end_time``
     - string
     - The ISO timestamp at which the |chef client| run finished. For example: ``'2014-06-05T10:39:43Z'``.
   * - ``error``
     - object
     - The details of errors that occurred during the |chef client| run, if present. For example:

       .. code-block:: javascript
       
          "error": {
            "class": "#<TypeError: user[chef] (/var/file.rb line 87) has error",
            "message": "user[chef] (/var/file.rb line 87) has error",
            "backtrace": "[\"/opt/chef/embedded/.../chef/unix.rb:103 \"]",
            "description": {
              "title": "Errorexecutingaction`create`onresource'user[chef]'",
              "sections": [
                { "TypeError": "can'tconvertArrayintoString" },
                { "CookbookTrace: ": "/var/chef/file.rb: 11: action: create\n" }
              ]
            }
          }

   * - ``id``
     - string
     - The internal message identifier for the |chef client| run. For example: ``'12345678-9012-3456-7890-12345678901211'``.
   * - ``node_name``
     - string
     - The name of the node on which the |chef client| run occurred. For example: ``'grantmc01-abc'``.
   * - ``organization_name``
     - string
     - The short name of the organization to which the node belongs. For example: ``'chef'``.
   * - ``resources``
     - array
     - An array of resources that were converged during the |chef client| run.
   * - ``run_id``
     - string
     - The identifier for the |chef client| run. For example: ``'67890123-4567-8901-2345-67890123456789'``.
   * - ``run_list``
     - array
     - The run-list used during the |chef client| run. For example: ``[ 'role[opscode-reporting]' ]``.
   * - ``start_time``
     - string
     - The ISO timestamp at which the |chef client| run started. For example: ``'2014-06-05T10:34:35Z'``.
   * - ``status``
     - string
     - The status of the |chef client| run. For example: ``'success'``.
   * - ``total_resource_count``
     - integer
     - The total number of resources in the resource collection for the |chef client| run. For example: ``4``.
   * - ``updated_resource_count``
     - integer
     - The total number of resources that were updated during the |chef client| run. For example: ``2``.
