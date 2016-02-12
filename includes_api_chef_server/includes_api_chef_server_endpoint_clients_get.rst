.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to return the |chef api client| list on the |chef server|, including nodes that have been registered with the |chef server|, the |chef validator| clients, and the |chef server webui| clients for the entire organization.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/NAME/clients

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "org1-validator" : "https://chef.example/orgaizations/org1/clients/org1-validator",
     "client1" : "https://chef.example/orgaizations/org1/clients/client1"
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
