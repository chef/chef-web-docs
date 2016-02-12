.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``POST`` method is used to add an action to the actions database.

This method has no parameters.

**Request**

.. code-block:: xml

   POST /messages

with a request body similar to:

.. code-block:: javascript

   {
     
   }

For example:

.. code-block:: javascript

   {
     "id": "b576b4a2-7b2a-43b8-b385-d6281e9a139e",
     "message_type": "action",
     "message_version": "0.1.1",
     "entity_name": "app1",
     "entity_type": "node",
     "organization_name": "ponyville",
     "recorded_at": "1976-10-02T05:00:37Z",
     "remote_hostname": "127.0.0.1",
     "remote_request_id": "562C4230-1569-4003-A81F-8C0100231D65",
     "request_id": "tG3MRbYB7NFWjFU8shs1YeSxq8CIIMJudpnHJXDnWEWzFSVW",
     "requestor_name": "rarity",
     "requestor_type": "user",
     "service_hostname": "127.0.0.1",
     "task": "delete",
     "user_agent": "Chef Client/0.10.0 (ruby-1.9.3-p484; x86_64-linux; +http://opscode.com)",
     "data": {"name": "app1"}
   }
   
**Response**

The response is similar to:

.. code-block:: javascript

   {
     "error": "Validation failed",
     "details": {
       "entity_name": "'' is not a valid entity name"
     }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - POST occurred during |chef client| run. POST is not persisted to actions database.
   * - ``201``
     - Success. The URL for the newly-cretaed action is returned.
   * - ``400``
     - Invalid content.
   * - ``405``
     - Invalid method.
