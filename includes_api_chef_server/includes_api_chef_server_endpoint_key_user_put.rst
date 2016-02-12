.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``PUT`` method is used to update one or more properties for a specific key for a specific user.

This method has no parameters.

**Request**

.. code-block:: xml

   PUT /users/USER/keys/KEY

with a request body similar to:

.. code-block:: javascript

   {
     "name" : "new_key_name",
     "public_key" : "-------- BEGIN PUBLIC KEY ----and a valid key here",
     "expiration_date" : "2020-12-31T00:00:00Z"
   }

**Response**

The response contains the updated inforamtion for the key, and is similar to:

.. code-block:: javascript

   {
     "name" : "new_key_name",
     "public_key" : "-------- BEGIN PUBLIC KEY --------- ...",
     "expiration_date" : "2020-12-31T00:00:00Z"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok|
   * - ``201``
     - |response code 201 created|
   * - ``401``
     - |response code 401 unauthorized|
   * - ``403``
     - |response code 403 forbidden|
   * - ``404``
     - |response code 404 not found|
