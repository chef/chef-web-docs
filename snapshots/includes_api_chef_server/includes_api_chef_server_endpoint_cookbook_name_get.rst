.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to return a hash that contains a key-value pair that corresponds to the specified cookbook, with a URL for the cookbook and for each version of the cookbook.

**Request**

.. code-block:: none

   GET /organizations/NAME/cookbooks/NAME

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "apache2": {
       "url": "https://localhost/cookbooks/apache2",
       "versions": [
         {"url": "https://localhost/cookbooks/apache2/5.1.0",
          "version": "5.1.0"},
         {"url": "https://localhost/cookbooks/apache2/4.2.0",
          "version": "4.2.0"}
       ]
     }
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
   * - ``404``
     - Not found. The requested object does not exist.
