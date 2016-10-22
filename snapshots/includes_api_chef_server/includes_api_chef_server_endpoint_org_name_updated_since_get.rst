.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to return the details of an organization as JSON.

**Request**

.. code-block:: none

   GET /organizations/NAME/objects_since?seq=NUM


where ``NUM`` is the largest integer previously returned as an identifier.

**Response**

The response will return an array of paths for objects that have been created, updated, or deleted since ``NUM``, similar to:

.. code-block:: javascript

   [
     {
       "action": "create",
       "id": 1,
       "path": "/roles/foo"
     },
     {
       "action": "create",
       "id": 2,
       "path": "/roles/foo2"
     },
     {
       "action": "create",
       "id": 3,
       "path": "/roles/foo3"
     },
     {
       "action": "update",
       "id": 4,
       "path": "/roles/foo3"
     }
   ]

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
