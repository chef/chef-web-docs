.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to return a list of all data bags on the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/data

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "users": "https://localhost/data/users",
     "applications": "https://localhost/data/applications"
   }

shown as a list of key-value pairs, where (in the example above) ``users`` and ``applications`` are the names of data bags and ``https://localhost/data/foo`` is the path to the data bag.

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
