.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``POST`` method is used to create a new alias for the specified organization.

This method has no parameters.

**Request**

.. code-block:: xml

   POST /organizations/NAME/aliases

with a request body similar to:

.. code-block:: javascript

   {
     "type": "object",
     "properties": {
       "name": {
         "description": "The name of the alias",
         "type": "string"
       },
       "modified_by": {
         "description": "user last modified",
         "type": "string"
       },
       "notification_type": {
         "description": "type of alias (e.g. hipchat, http)",
         "type": "string",
         "enum": [
           "http",
           "hipchat"
         ]
       },
       "delivery_options": {
         "description": "set of settings this notification_type needs",
         "type": "object",
         "oneOf": [
           {"$ref": "#/definitions/hipchat"},
           {"$ref": "#/definitions/http"}
         ]
       }
     },
     "required": [ "notification_type", "modified_by", "name" ],
     "definitions": {
       ...
     }
   }
   
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
   * - ``201``
     - Success.
   * - ``409``
     - Duplicate alias exists in organization.
