.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``DELETE`` method is used to remove a specific |chef api client|.

This method has no parameters.

**Request**

.. code-block:: xml

   DELETE /organizations/NAME/clients/NAME

This method has no request body.

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name" : "client1",
     "validator" : "false"
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
   * - ``404``
     - |response code 404 not found|
