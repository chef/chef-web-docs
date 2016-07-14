.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get |oauth| 2.0 configuration details.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /authentication-configuration
   
**Response**

The response is similar to:

.. code-block:: javascript

   {
     "client_id": "abf783ad98b53496asdfe3d682f5c70b68fddsdff87c463b128d540587ab9f",
     "profile_uri": "https://api.opscode.piab/id/v1/me",
     "redirect_uri": "https://analytics.opscode.piab/auth/chef/callback",
     "scope": "",
     "site": "https://api.opscode.piab/id"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok|
