.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to return all of the data that matches the query in the ``GET`` request.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``q``
     - |SEARCH_QUERY|
   * - ``rows``
     - |rows|
   * - ``sort``
     - |sort|
   * - ``start``
     - |start|

**Request**

.. code-block:: xml

   GET /organizations/NAME/search/INDEX

**Response**

The response contains the total number of rows that match the request and is similar to:

.. code-block:: javascript

   {
    "total": 1,
    "start": 0,
    "rows": [
       {
        "overrides": {"hardware_type": "laptop"},
        "name": "latte",
        "chef_type": "node",
        "json_class": "Chef::Node",
        "attributes": {"hardware_type": "laptop"},
        "run_list": ["recipe[unicorn]"],
        "defaults": {}
       }
     ]
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
