.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``POST`` method is used to create a new data bag on the |chef server|.

This method has no parameters.

**Request**

.. code-block:: xml

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
      "chef_type" => "environment"
      "data_bag" => "data123"
      "id" => "12345"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``201``
     - |response code 201 created|
   * - ``400``
     - |response code 400 bad request|
   * - ``401``
     - |response code 401 unauthorized|
   * - ``403``
     - |response code 403 forbidden|
   * - ``409``
     - |response code 409 unauthorized|
   * - ``413``
     - |response code 413 entity_too_large|
