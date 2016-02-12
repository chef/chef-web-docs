.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to return a hash that contains a key-value pair that corresponds to the specified cookbook, with a URL for the cookbook and for each version of the cookbook.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``num_versions=n``
     - |num_versions|

**Request**

.. code-block:: xml

   GET /organizations/NAME/cookbooks/NAME

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "apache2" => {
       "url" => "https://localhost/cookbooks/apache2",
       "versions" => [
         {"url" => "https://localhost/cookbooks/apache2/5.1.0",
          "version" => "5.1.0"},
         {"url" => "https://localhost/cookbooks/apache2/4.2.0",
          "version" => "4.2.0"}
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
     - |response code 200 ok|
   * - ``401``
     - |response code 401 unauthorized|
   * - ``403``
     - |response code 403 forbidden|
   * - ``404``
     - |response code 404 not found|
