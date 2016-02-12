.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``PUT`` method is used to commit files that are in a sandbox to their final location so that changes to cookbooks will not require re-uploading the same data.

This method has no parameters.

**Request**

.. code-block:: xml

   PUT /organizations/NAME/sandboxes/ID

with a request body similar to:

.. code-block:: javascript

   {"is_completed":true}

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "guid": guid,
     "name": guid,
     "checksums":
       {"385ea5490c86570c7de71070bce9384a":
       {"url":
         "https://s3.amazonaws.com/opscode-platform-production-data/organization-(...)",
         "needs_upload":true}
     },
     "create_time": <get an example of time format>,
     "is_completed": true
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok|
   * - ``400``
     - |response code 400 bad request|
   * - ``401``
     - |response code 401 unauthorized|
   * - ``403``
     - |response code 403 forbidden|
   * - ``404``
     - |response code 404 not found|
   * - ``413``
     - |response code 413 entity_too_large|
