.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``POST`` method is used to authenticate a user. This endpoint is used by the Chef Identity Service to authenticate users of Chef Supermarket and Chef Analytics to the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   POST /organizations/NAME/authenticate_user

with a request body similar to:

.. code-block:: javascript

   {
     "username" : "grantmc",
     "password" : "p@ssw0rd"
   }

**Response**

This method has no response body.

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

