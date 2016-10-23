.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get a list of cookbooks and cookbook versions that are available to the specified environment.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``num_versions=n``
     - The number of cookbook versions to include in the response, where ``n`` is the number of cookbook versions. For example: ``num_versions=3`` returns the three latest versions, in descending order (newest to oldest). Use ``num_versions=all`` to return all cookbook versions. If ``num_versions`` is not specified, a single cookbook version is returned. ``0`` is an invalid input (an empty array for the versions of each cookbook is returned).

**Request**

.. code-block:: none

   GET /organizations/NAME/environments/NAME/cookbooks

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
     },
     "nginx": {
       "url": "https://localhost/cookbooks/nginx",
       "versions": [
         {"url": "https://localhost/cookbooks/nginx/1.0.0",
          "version": "1.0.0"},
         {"url": "https://localhost/cookbooks/nginx/0.3.0",
          "version": "0.3.0"}
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
