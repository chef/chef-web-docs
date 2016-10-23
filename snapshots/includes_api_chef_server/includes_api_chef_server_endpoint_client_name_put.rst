.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``PUT`` method is used to update a specific API client. If values are not specified for the ``PUT`` method, the Chef server will use the existing values rather than assign default values.

.. note:: ``PUT`` supports renames. If ``PUT /user/foo`` is requested with ``{ "name: "bar""}``, then it will rename ``foo`` to ``bar`` and all of the content previously associated with ``foo`` will be associated with ``bar``.

This method has no parameters.

**Request**

.. code-block:: none

   PUT /organizations/NAME/clients/NAME

with a request body similar to:

.. code-block:: javascript

   {
     "name": "monkeypants",
     "private_key": true,
     "admin": false
   }

where ``private_key`` (when ``true``) will generate a new RSA private key for the API client. If ``admin`` is set to ``true`` the API client will be promoted to an admin API client.

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "uri" : "https://chef.example/orgaizations/org1/clients/client1"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``201``
     - Created. The object was created. (This response code is only returned when the client is renamed.)
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.
   * - ``409``
     - Unauthorized. The user who made the request is not authorized to perform the action. (This response code is only returned when a client is renamed, but a client already exists with that name.)
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.
