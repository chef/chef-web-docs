.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following fields are available for the ``run_control`` message type:

.. list-table::
   :widths: 120 60 320
   :header-rows: 1

   * - Field
     - Type
     - Description
   * - ``context``
     - array
     - 
   * - ``control_group``
     - object
     - A |json| object that contains the control group identifier, the name of the control group, the number of tests that passed and failed, and its final status.
   * - ``control_group.control_group_id``
     - string
     - The identifier of the control group object. For example: ``'12345678-9012-3456-7890-12345678901211'``.
   * - ``control_group.name``
     - string
     - The name of the control group. For example: ``'mysql audit'``.
   * - ``control_group.number_failed``
     - integer
     - The number of tests within the control group that failed. For example: ``7``.
   * - ``control_group.number_succeeded``
     - integer
     - The number of tests within the control group that passed. For example: ``4``.
   * - ``control_group.status``
     - string
     - The status of the control group. For example: ``'success'``.
   * - ``details``
     - ["string", "null"] 
     - Details about the control object.
   * - ``id``
     - string
     - The globaly-unique identifier for this message. For example: ``'12345678-9012-3456-7890-12345678901211'``.
   * - ``name``
     - string
     - The name of the control object. For example: ``'should be installed'``.
   * - ``organization_name``
     - string
     - The short name of the organization to which the node belongs. For example: ``'chef'``.
   * - ``resource_name``
     - ["string", "null"]
     - The name of the resource in which the control object is present. For example: ``'mysql'``.
   * - ``resource_type``
     - ["string", "null"]
     - The resource type for the control object. For example: ``'Package'``.
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
     - The internal message identifier for the |chef client| run. For example: ``'12345678-9012-3456-7890-12345678901211'``.
   * - ``run.start_time``
     - string
     - The ISO timestamp at which the |chef client| run started. For example: ``'2014-06-05T10:34:35Z'``.
   * - ``sequence_number``
     - integer
     - The sequence number at which the resource converged. For example: ``2``.
   * - ``status``
     - string
     - The status of the control object. For example: ``'success'``.
