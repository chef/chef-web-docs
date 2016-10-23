.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``PUT`` method is used to commit files that are in a sandbox to their final location so that changes to cookbooks will not require re-uploading the same data.

This method has no parameters.

**Request**

.. code-block:: none

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
     - OK. The request was successful.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.
