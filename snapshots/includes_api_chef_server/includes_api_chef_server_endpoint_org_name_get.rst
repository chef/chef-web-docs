.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get the details for the named organization.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME

**Response**

The response is similar to:

.. code-block:: none

   {
     "name": "chef",
     "full_name": "Chef Software, Inc",
     "guid": "f980d1asdfda0331235s00ff36862"
	    ...
   } 

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
