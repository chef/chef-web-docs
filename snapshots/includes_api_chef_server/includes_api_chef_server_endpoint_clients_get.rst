.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to return the API client list on the Chef server, including nodes that have been registered with the Chef server, the chef-validator clients, and the chef-server-webui clients for the entire organization.

This method has no parameters.

**Request**

.. code-block:: none

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
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
