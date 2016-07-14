.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``POST`` method is used to create a new rule for the named organization.

This method has no parameters.

**Request**

.. code-block:: xml

   POST /organization/NAME/rules

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
     - |response code 201 created| The location of the new rule is returned.
   * - ``409``
     - Duplicate rule name.
