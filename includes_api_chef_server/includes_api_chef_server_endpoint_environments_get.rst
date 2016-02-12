.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to return a data structure that contains a link to each available environment.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/NAME/environments

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "_default": "https://api.opscode.com/organizations/org_name/environments/_default",
     "webserver": "https://api.opscode.com/organizations/org_name/environments/webserver"
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
