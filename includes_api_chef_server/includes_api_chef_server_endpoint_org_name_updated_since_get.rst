.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to return the details of an organization as |json|.

**Request**

.. code-block:: xml

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
     - |response code 200 ok|
   * - ``401``
     - |response code 401 unauthorized|
   * - ``403``
     - |response code 403 forbidden|
   * - ``404``
     - |response code 404 not found|