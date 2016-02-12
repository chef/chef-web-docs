.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

**THIS ENDPOINT IS NOT PART OF THE CHEF API. IT IS AN IMPLEMENTATION DETAIL OF LOCAL COOKBOOK STORAGE. THIS TOPIC IS NOT INCLUDED IN THE PUBLISHED DOCS.**

The ``PUT`` method is used to add a checksum to a sandbox.

This method has no parameters.

**Request**

.. code-block:: xml

   PUT /organizations/NAME/sandboxes/ID/CHECKSUM

where ``CHECKSUM`` is the file in which a checksum is located.

**Response**

This method has no response body.

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok|
   * - ``400``
     - |response code 400 checksum|
   * - ``401``
     - |response code 401 unauthorized|
   * - ``403``
     - |response code 403 forbidden|
   * - ``413``
     - |response code 413 entity_too_large|