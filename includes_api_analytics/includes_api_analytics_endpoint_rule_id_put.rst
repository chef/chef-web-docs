.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``PUT`` method is used to edit an existing rule.

This method has no parameters.

**Request**

.. code-block:: xml

   PUT /organizations/NAME/rules/ID

with a request body similar to:

.. code-block:: javascript

   {
     "type": "object",
     "properties": {
       "active": {
         "type": "boolean"
       },
       "name": {
         "description": "Rule name",
         "type": "string"
       },
       "modified_by": {
         "description": "user last modified",
         "type": "string"
       },
       "rule": {
         "description": "text of rule",
         "type": "string"
       },
       "with": {
         "type": "object",
         "properties": {
           "priority": {
             "type": "integer"
           }
         },
         "required": ["priority"]
       }
     },
     "required": [ "rule", "modified_by", "with", "active"]
   }
   
**Response**

The response will return the |json| for the updated rule.

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``204``
     - Success.
