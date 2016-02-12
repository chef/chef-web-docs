.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``POST`` method is used to create a new environment.

This method has no parameters.

**Request**

.. code-block:: xml

   POST /organizations/NAME/environments

with a request body similar to:

.. code-block:: javascript

   {
     "name": "dev",
     "default_attributes": {},
     "json_class": "Chef::Environment",
     "description": "",
     "cookbook_versions": {},
     "chef_type": "environment"
   }

**Response**

The response is similar to:

.. code-block:: javascript

   { "uri": "https://localhost/environments/dev" }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``201``
     - |response code 201 created|
   * - ``400``
     - |response code 400 bad request|
   * - ``401``
     - |response code 401 unauthorized|
   * - ``403``
     - |response code 403 forbidden|
   * - ``409``
     - |response code 409 conflict|
   * - ``413``
     - |response code 413 entity_too_large|
