.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get a list of audits for the named organization. Use query parameters to filter the list of audits.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``before``
     - The time before which audit data is returned. For example: ``2014-11-14T18:50:09.155Z``.
   * - ``level``
     - The audit level. Possible values: ``error``, ``info``, and ``warn``. Use a comma to separate multiple audit levels. For example: ``error`` or ``warn, info``.
   * - ``page``
     - The page number to be returned.
   * - ``since``
     - The time after which audit data is returned. For example: ``2014-11-14T18:40:09.155Z``.
   * - ``type``
     - The types of events that trigger audits: ``action``, ``run_control``, ``run_control_group``, ``run_converge``, ``run_resource``, or ``run_start``. Use a comma to separate multiple types. For example: ``run_converge`` or ``action, run_start``.

**Request**

.. code-block:: xml

   GET /organizations/NAME/audits
   
**Responses**

A response for ``action`` is similar to:

.. code-block:: javascript

   {
     "id": "cb17e360-a729-4112-b5b6-713a8e213c55",
     "recorded_at": "2014-11-14T03:02:09.000Z",
     "description": "Oh oh, we didn't meet the audit criteria!",
     "level": "warn",
     "organization": "ponyville",
     "type": "audit",
     "auditable": {
       "id": "3e1fb0dd-eaeb-43cb-8df7-827376bc3f59",
       "tags": [
         "foo:create"
       ],
       "recorded_at": "2014-11-14T03:02:09.000Z",
       "remote_hostname": "33.33.33.10",
       "remote_request_id": null,
       "request_id": "g3IAA2QAEGVyY2hlZkAxMjcuMC4wLjEBAAPZYgAAAAUAAAAA",
       "service_hostname": "api.opscode.piab",
       "task": "create",
       "type": "action",
       "endpoint": "/actions/3e1fb0dd-eaeb-43cb-8df7-827376bc3f59",
       "user_agent": "Chef Manage/11.10.4 (ruby-1.9.3-p547; ohai-6.20.0; x86_64-linux; +http://opscode.com)",
       "requestable": {
         "name": "applejack",
         "properties": {
           "avatar_url": null,
           "email": null,
           "gravatar_id": null
         },
         "type": "user",
         "endpoint": "/users/applejack"
     },
     "entity": {
       "name": "b",
       "manage": "https://api.opscode.piab/organizations/ponyville/data_bags/b",
       "parent": null,
       "type": "bag",
       "endpoint": "/organizations/ponyville/bags/b"
       }
     }
   }

A response for ``run_control`` is similar to:

.. code-block:: javascript

   {
     "id": "2121e899-9f84-43b9-8933-53fe864e163d",
     "recorded_at": "2014-11-22T22:43:37.000Z",
     "description": "Control error",
     "level": "error",
     "organization": "ponyville",
     "type": "audit",
     "auditable": {
       "id": "6035b05b-1514-4006-9edd-787212a30074",
       "name": "should be mode 600",
       "status": "success",
       "details": null,
       "resource_name": "/etc/ssh/ssh_host_dsa_key",
       "resource_type": "File",
       "context": null,
       "sequence_number": 10,
       "tags": [],
       "type": "run_control"
     }
   }

A response for ``run_control_group`` is similar to:

.. code-block:: javascript

   {
     "id": "92850c77-d581-493a-afd1-e502cfa8eb4d",
     "recorded_at": "2014-11-22T22:43:37.000Z",
     "description": "Control group had too many failures",
     "level": "warn",
     "organization": "ponyville",
     "type": "audit",
     "auditable": {
       "id": "6a8803b3-7a98-46e8-87a7-a7a9d5d37d97",
       "name": "Database",
       "status": "success",
       "number_success": 2,
       "number_failed": 0,
       "tags": [],
       "error": null,
       "type": "run_control_group"
     }
   }

A response for ``run_converge`` is similar to:

.. code-block:: javascript

   {
     "id": "98f9e4ac-1c97-4d9b-8175-4fca28a1d37d",
     "recorded_at": "2014-11-22T22:49:04.000Z",
     "description": "Run Converge",
     "level": "warn",
     "organization": "ponyville",
     "type": "audit",
     "auditable": {
       "error": null,
       "id": "21e4924d-d395-49b4-8f9d-6934f2fecf24",
       "end_time": "2014-11-22T22:49:04.000Z",
       "node_name": "client1.opscode.piab",
       "run_id": "4a2c115e-5d99-4201-916f-eac723ed9f1d",
       "run_list": [
         "recipe[apt]"
       ],
       "status": "success",
       "start_time": "2014-11-22T22:49:04.000Z",
       "total_resource_count": 8,
       "updated_resource_count": 2,
       "type": "run_converge"
     }
   }

A response for ``run_resource`` is similar to:

.. code-block:: javascript

   {
     "id": "d833b937-1162-42af-b01c-2bcdc4891951",
     "recorded_at": "2014-11-22T21:12:25.000Z",
     "description": "Run Resource",
     "level": "warn",
     "organization": "ponyville",
     "type": "audit",
     "auditable": {
       "id": "9aa9fdc1-9524-45fb-81b4-123f91306b27",
       "sequence": 3,
       "resource_id": "update-notifier-common",
       "resource_name": "update-notifier-common",
       "resource_type": "apt_package",
       "resource_result": "install",
       "initial_state": {
         "version": null,
         "options": null
       },
       "final_state": {
         "version": "0.119ubuntu8.7",
         "options": null
       },
       "delta": "",
       "cookbook_name": "apt",
       "cookbook_version": "2.6.0",
       "tags": [],
       "type": "run_resource"
     }
   }

A response for ``run_start`` is similar to:

.. code-block:: javascript

   {
     "id": "33ecf37d-dea0-4063-9607-60268f45bfab",
     "recorded_at": "2014-11-22T22:49:04.000Z",
     "description": "Run Start",
     "level": "warn",
     "organization": "ponyville",
     "type": "audit",
     "auditable": {
       "id": "4a2c115e-5d99-4201-916f-eac723ed9f1d",
       "node_name": "client1.opscode.piab",
       "organization": "ponyville",
       "start_time": "2014-11-22T22:49:04.000Z",
       "run_id": "4a2c115e-5d99-4201-916f-eac723ed9f1d",
       "tags": [],
       "type": "run_start"
     }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok|
