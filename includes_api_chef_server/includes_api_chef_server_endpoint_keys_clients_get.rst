.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to retrieve all of the named client's key identifiers, associated URIs, and expiry states.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/NAME/client/CLIENT/keys

**Response**

The response is similar to:

.. code-block:: javascript

   [
     { "name" : "default",
                "uri" : "https://chef.example/organizations/example/client/client1/keys/default",
                "expired" : false },
     { "name" : "key1",
                "uri" : "https://chef.example/organizations/example/client/client1/keys/key1",
                "expired" : true }
   ]

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
   * - ``404``
     - |response code 404 not found|
