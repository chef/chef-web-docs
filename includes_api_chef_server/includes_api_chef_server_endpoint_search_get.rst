.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to return a data structure that contains links to each available search index. By default, the ``role``, ``node``, ``client``, and ``data bag`` indexes will always be available (where the ``data bag`` index is the name of the data bag on the |chef server|). Search indexes may lag behind the most current data at any given time. If a situation occurs where data needs to be written and then immediately searched, an artificial delay (of at least 10 seconds) is recommended.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/NAME/search

This method has no request body.

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "node": "https://localhost/search/node",
     "role": "https://localhost/search/role",
     "client": "https://localhost/search/client",
     "users": "https://localhost/search/users"
   }

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
