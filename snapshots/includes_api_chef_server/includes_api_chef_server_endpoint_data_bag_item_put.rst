.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``PUT`` method is used to replace the contents of a data bag item with the contents of this request.

This method has no parameters.

**Request**

.. code-block:: none

   PUT /organizations/NAME/data/NAME/ITEM

with a request body similar to:

.. code-block:: javascript

   {
     "real_name": "Adam Brent Jacob",
     "id": "adam"
   }

where ``id`` is required.

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "real_name": "Adam Brent Jacob",
     "id": "adam"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.
