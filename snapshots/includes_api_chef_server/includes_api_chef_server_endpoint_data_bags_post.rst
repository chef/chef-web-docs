.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``POST`` method is used to create a new data bag on the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   POST /organizations/NAME/data

with a request body that contains the key-value pair for the data bag and is similar to:

.. code-block:: javascript

   {
     "name": "users"
   }

where (in the example above) ``name`` is the key and "users" is the value.

**Response**

The response is similar to:

.. code-block:: javascript

   {
      "chef_type": "environment",
      "data_bag": "data123",
      "id": "12345"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``201``
     - Created. The object was created.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``409``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.
