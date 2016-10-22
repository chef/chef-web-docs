.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``PUT`` method is used to create an organization.

This method has no parameters.

**Request**

.. code-block:: none

   PUT /organizations/NAME

with a request body similar to:

.. code-block:: javascript

   {
     "name": "chef",
     "full_name": "Chef Software, Inc"
   }

**Response**

The response will return the JSON for the updated organization.

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
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``410``
     - Gone. Unable to update private key.
