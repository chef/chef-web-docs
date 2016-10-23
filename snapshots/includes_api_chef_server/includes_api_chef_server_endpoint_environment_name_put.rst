.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``PUT`` method is used to update the details of an environment on the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   PUT /organizations/NAME/environments/NAME

with a request body that contains the updated JSON for the environment and is similar to:

.. code-block:: javascript

   {
     "name": "dev",
     "attributes": {},
     "json_class": "Chef::Environment",
     "description": "The Dev Environment",
     "cookbook_versions": {},
     "chef_type": "environment"
   }

**Response**

The response will return the updated environment.

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.
