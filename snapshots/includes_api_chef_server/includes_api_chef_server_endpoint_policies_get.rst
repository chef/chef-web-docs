.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get a list of policies (including policy revisions) from the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/policies

**Response**

The response groups policies by name and revision and is similar to:

.. code-block:: javascript

   {
     "aar": {
       "uri": "https://chef.example/organizations/org1/policies/aar",
       "revisions": {
         "37f9b658cdd1d9319bac8920581723efcc2014304b5f3827ee0779e10ffbdcc9": {
         },
         "95040c199302c85c9ccf1bcc6746968b820b1fa25d92477ea2ec5386cd58b9c5": {
         },
         "d81e80ae9bb9778e8c4b7652d29b11d2111e763a840d0cadb34b46a8b2ca4347": {
         }
       }
     },
     "jenkins": {
       "uri": "https://chef.example/organizations/org1/policies/jenkins",
       "revisions": {
         "613f803bdd035d574df7fa6da525b38df45a74ca82b38b79655efed8a189e073": {
         },
         "6fe753184c8946052d3231bb4212116df28d89a3a5f7ae52832ad408419dd5eb": {
         },
         "cc1a0801e75df1d1ea5b0d2c71ba7d31c539423b81478f65e6388b9ee415ad87": {
         }
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
     - OK. The request was successful.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
