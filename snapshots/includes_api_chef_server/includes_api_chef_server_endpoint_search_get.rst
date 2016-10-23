.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to return a data structure that contains links to each available search index. By default, the ``role``, ``node``, ``client``, and ``data bag`` indexes will always be available (where the ``data bag`` index is the name of the data bag on the Chef server). Search indexes may lag behind the most current data at any given time. If a situation occurs where data needs to be written and then immediately searched, an artificial delay (of at least 10 seconds) is recommended.

This method has no parameters.

**Request**

.. code-block:: none

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
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
