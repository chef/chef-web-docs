.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to return a list of all data bags on the |chef server|.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/NAME/data

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "users": "https://localhost/data/users",
     "applications": "https://localhost/data/applications"
   }

shown as a list of key-value pairs, where (in the example above) ``users`` and ``applications`` are the names of data bags and "https://localhost/data/foo" is the path to the data bag.

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok|
   * - ``401``
     - |response code 401 unauthorized|
   * - ``403``
     - |response code 403 forbidden|
