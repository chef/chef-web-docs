.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``POST`` method is used to create a new sandbox. This method accepts a list of checksums as input and returns the URLs against which to ``PUT`` files that need to be uploaded.

This method has no parameters.

**Request**

.. code-block:: xml

   POST /organizations/NAME/sandboxes

with a request body similar to:

.. code-block:: javascript

   {"checksums": {
     "385ea5490c86570c7de71070bce9384a":null,
     "f6f73175e979bd90af6184ec277f760c":null,
     "2e03dd7e5b2e6c8eab1cf41ac61396d5":null
     }
   }

**Response**

The response is similar to:

.. code-block:: javascript

   {"uri":
    "https://api.opscode.com/organizations/testorg/sandboxes/eff7b6f8b3ef44c6867216662d5eeb5f",
    "checksums":
      {"385ea5490c86570c7de71070bce9384a":
        {"url":
         "https://s3.amazonaws.com/opscode-platform-production-data/organization-(...)",
          "needs_upload":true},
          "f6f73175e979bd90af6184ec277f760c"=>
        {"url":
          "https://s3.amazonaws.com/opscode-platform-production-data/organization-(...)",
          "needs_upload":true},
          "2e03dd7e5b2e6c8eab1cf41ac61396d5":
        {"url":
          "https://s3.amazonaws.com/opscode-platform-production-data/organization-(...)",
          "needs_upload":true}
      },
    "sandbox_id"=>"eff7b6f8b3ef44c6867216662d5eeb5f"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok| A hash that maps each checksum to a hash that contains a boolean ``needs_upload`` field and a URL if ``needs_upload`` is set to ``true``.
   * - ``400``
     - |response code 400 bad request sandbox| The payload does not contain a well-formed ``checksums`` parameter that is a hash containing a key for each checksum.
   * - ``401``
     - |response code 401 unauthorized|
   * - ``403``
     - |response code 403 forbidden|
   * - ``413``
     - |response code 413 entity_too_large|
