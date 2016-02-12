.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to return a list of nodes in a given environment.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/NAME/environments/NAME/nodes

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "blah": "https://api.opscode.com/org/org_name/nodes/_default",
     "boxer": "https://api.opscode.com/org/org_name/nodes/frontend",
     "blarrrrgh": "https://api.opscode.com/org/org_name/nodes/backend"
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
