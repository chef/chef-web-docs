.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get information about the specified alias.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/NAME/aliases/ID
   
**Response**

The response is similar to:

.. code-block:: javascript

   {
     "type": "object",
     "properties": {
       "id": {
         ...
       },
       "name": {
         ...
       },
       "org_name": {
         ...
       },
       "modified_by": {
         ...
       },
       "modified_at": {
         ...
       },
       "notification_type": {
         ...
       },
       "delivery_options": {
         ...
       }
     },
     "required": [ "notification_type", "modified_by", "name" ],
     "definitions": {
       "hipchat": {
         ...
       },
       "http": {
         ...
       },
       "smtp": {
         ...
       }
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
