.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``POST`` method is used to create a new API client.

This method has no parameters.

**Request**

.. code-block:: none

   POST /organizations/NAME/clients

with a request body similar to:

.. code-block:: javascript

   {
     "name": "name_of_API_client",
     "admin": false,
     "create_key": true
   }

where ``name_of_API_client`` is the name of the API client to be created and ``admin`` indicates whether the API client will be run as an admin API client.

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "uri": "https://chef.example/orgaizations/org1/clients/client1",
     "chef_key": {
       "name": "default",
       "public_key": "-----BEGIN PUBLIC KEY-----",
       "private_key": "-----BEGIN RSA PRIVATE KEY-----"
   }

Store the private key in a safe place. It will be required later (along with the client name) to access the Chef server when using the Chef server API.

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
     - Conflict. The object already exists.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.
