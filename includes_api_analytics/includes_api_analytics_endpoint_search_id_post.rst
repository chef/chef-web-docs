.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``POST`` method is used to create a new search item.

This method has no parameters.

**Request**

.. code-block:: xml

   POST /searches/ID

with a request body similar to:

.. code-block:: javascript

   {
     "type": "object",
     "properties": {
       "description": {
         "type": "string"
       },
       "id": {
         "type": "integer",
         "format": "uint"
       },
       "query": {
         "type": "string",
         "format": "search-query"
       }
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
   * - ``200``
     - |response code 200 ok|
   * - ``403``
     - Unauthorized.
   * - ``500``
     - Internal error.
