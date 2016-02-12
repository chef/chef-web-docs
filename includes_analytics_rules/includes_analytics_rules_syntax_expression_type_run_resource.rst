.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following fields are available for the ``run_resource`` message type:

.. list-table::
   :widths: 120 60 320
   :header-rows: 1

   * - Field
     - Type
     - Description
   * - ``converge``
     - object
     - A |json| object that contains the status of the |chef client| run, the name of the organization, the run-list, total resource count, updated resource count, the run identifier, and the times at which the |chef client| started and finished.
   * - ``converge.end_time``
     - string
     - The ISO timestamp at which the |chef client| run finished. For example: ``'2014-06-05T10:39:43Z'``.
   * - ``converge.id``
     - string
     - The internal message identifier for the |chef client| run. For example: ``'12345678-9012-3456-7890-12345678901211'``.
   * - ``converge.organization_name``
     - string
     - The name of the organization to which the node belongs. For example: ``'chef'``.
   * - ``converge.run_list``
     - array
     - The run-list used during the |chef client| run. For example: ``[ 'role[opscode-reporting]' ]``.
   * - ``converge.start_time``
     - string
     - The ISO timestamp at which the |chef client| run started. For example: ``'2014-06-05T10:34:35Z'``.
   * - ``converge.status``
     - string
     - The status of the |chef client| run. For example: ``'success'``.
   * - ``converge.total_resource_count``
     - integer
     - The total number of resources that were converged during the |chef client| run. For example: ``4``.
   * - ``converge.updated_resource_count``
     - integer
     - The total number of resources that were updated during the |chef client| run. For example: ``2``.
   * - ``cookbook_name``
     - string
     - The name of the cookbook that initiated the changes made by this |chef client| run. For example: ``'chef_handler'``.
   * - ``cookbook_version``
     - string
     - The version of the cookbook initiated the changes made by this |chef client| run. For example: ``'0.2.3'``.
   * - ``delta``
     - string
     - The difference between the intial and final value of resource. For example:
       
       .. code-block:: javascript
       
          --- /etc/motd.tail
          2013-06-30 17:41:31.667050237 -0600\n
          +++ /tmp/chef-rendered-template 18:11:54.7 -0600\n
          @@ -3,7 +3,7 @@\n
          Chef-Client - jenkins\n
          Hostname: jenkins.int.housepub.org\n
          Chef Server: https://api.chef.io/orgs/org\n
          -Last Run: 2013-06-30 17:41:31 -0600\n
          +Last Run:2013-06-30 18:11:54 -0600\n
          \n
          Roles:\n
          debian

   * - ``duration``
     - string
     - The duration of the |chef client| run. For example: ``'1200'``.
   * - ``final_state``
     - object
     - A |json| object that contains the final state of the resource, including a checksum, owner, group, and mode.
   * - ``id``
     - string
     - The internal message identifier for the |chef client| run. For example: ``'12345678-9012-3456-7890-12345678901211'``.
   * - ``initial_state``
     - object
     - A |json| object that contains the initial state of the resource, including a checksum, owner, group, and mode.
   * - ``resource_id``
     - string
     - The resource identifier. For example: ``'/var/cache/mod_auth_openid/mod_auth_openid.db'``.
   * - ``resource_name``
     - string
     - The name of the resource. For example: ``'/var/cache/mod_auth_openid/mod_auth_openid.db'``.
   * - ``resource_result``
     - string
     - The resource result. For example: ``'delete'``.
   * - ``resource_type``
     - string
     - The resource type. For example: ``'file'``.
   * - ``run``
     - object
     - A |json| object that contains run data, including the |chef client| run identifier, the |fqdn| for the |chef server|, the name of the node, and the times at which the |chef client| started and finished.
   * - ``run.chef_server_fqdn``
     - string
     - The |fqdn| for the |chef server| against which the instance is running. For example: ``'api.chef.io'``.
   * - ``run.end_time``
     - string
     - The ISO timestamp at which the |chef client| run finished. For example: ``'2014-06-05T10:39:43Z'``.
   * - ``run.node_name``
     - string
     - The name of the node on which the |chef client| run occurred. For example: ``'grantmc01-abc'``.
   * - ``run.run_id``
     - string
     - The identifier for the |chef client| run. For example: ``'67890123-4567-8901-2345-67890123456789'``.
   * - ``run.start_time``
     - string
     - The ISO timestamp at which the |chef client| run started. For example: ``'2014-06-05T10:34:35Z'``.
   * - ``sequence_number``
     - integer
     - The sequence number at which the resource converged. For example: ``0``.
