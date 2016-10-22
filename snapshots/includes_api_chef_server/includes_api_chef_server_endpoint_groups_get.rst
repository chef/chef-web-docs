.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get a list of groups on the Chef server for a single organization.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/groups

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "33a5c28a8efe11e195005fsaes25400298d3f": "https://url/for/group1",
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
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.
