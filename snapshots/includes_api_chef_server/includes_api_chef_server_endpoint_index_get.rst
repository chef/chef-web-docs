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
     - The search query used to identify a list of items on a Chef server. This option uses the same syntax as the ``search`` subcommand.
   * - ``rows``
     - The number of rows to be returned.
   * - ``sort``
     - The order in which search results are to be sorted.
   * - ``start``
     - The row at which return results begin.

**Request**

.. code-block:: none

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
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.
