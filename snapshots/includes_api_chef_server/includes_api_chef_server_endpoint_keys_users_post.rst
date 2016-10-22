.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``POST`` method is used to add a key for the specified user.

This method has no parameters.

**Request**

.. code-block:: none

   POST /users/USER/keys/

with a request body similar to:

.. code-block:: javascript

   {
     "name" : "key1",
     "public_key" : "-------- BEGIN PUBLIC KEY ----and a valid key here",
     "expiration_date" : "infinity"
   }

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "uri" : "https://chef.example/users/user1/keys/key1"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``201``
     - Created. The object was created.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.
