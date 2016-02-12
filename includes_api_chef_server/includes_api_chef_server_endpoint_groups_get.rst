.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get a list of groups on the |chef server| for a single organization.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/NAME/groups

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "33a5c28a8efe11e195005fsaes25400298d3f": "https://url/for/group1"
     "admins": "https://url/for/groups/admins",
     "billing-admins": "https://url/for/billing-admins",
     "clients": "https://url/for/clients",
     "developers": "https://url/for/developers",
     "users": "https://url/for/groups/users"
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
