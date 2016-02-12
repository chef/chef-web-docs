.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``DELETE`` method is used to delete a policy group that is stored on the |chef server|.

This method has no parameters.

**Request**

.. code-block:: xml

   DELETE /organizations/NAME/policy_groups/NAME

**Response**

The response returns the policy details and is similar to:

.. code-block:: javascript

   {
     "uri": "https://chef.example/organizations/org1/policy_groups/dev",
     "policies": {
       "aar": {
         "revision_id": "95040c199302c85c9ccf1bcc6746968b820b1fa25d92477ea2ec5386cd58b9c5"
       },
       "jenkins": {
         "revision_id": "613f803bdd035d574df7fa6da525b38df45a74ca82b38b79655efed8a189e073"
       }
     }
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
   * - ``404``
     - |response code 404 not found|
