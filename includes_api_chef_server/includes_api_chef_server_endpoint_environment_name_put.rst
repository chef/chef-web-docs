.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``PUT`` method is used to update the details of an environment on the |chef server|.

This method has no parameters.

**Request**

.. code-block:: xml

   PUT /organizations/NAME/environments/NAME

with a request body that contains the updated |json| for the environment and is similar to:

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
     - |response code 200 ok|
   * - ``401``
     - |response code 401 unauthorized|
   * - ``403``
     - |response code 403 forbidden|
   * - ``404``
     - |response code 404 not found|
   * - ``413``
     - |response code 413 entity_too_large|
