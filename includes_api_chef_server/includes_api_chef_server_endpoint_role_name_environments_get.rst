.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method returns a list of the environments that have environment-specific run-lists in the given role as |json| data.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/NAME/roles/NAME/environments

**Response**

The response is similar to:

.. code-block:: javascript

   ["_default","production","qa"]

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
