.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``PUT`` method is used to update a node.

This method has no parameters.

**Request**

.. code-block:: xml

   PUT /organizations/NAME/nodes/NAME

with a request body similar to:

.. code-block:: javascript

   {
     "overrides": {},
     "name": "latte",
     "chef_type": "node",
     "json_class": "Chef::Node",
     "attributes": {
       "hardware_type": "laptop"
     },
     "run_list": [
       'recipe[cookbook_name::recipe_name],
       role[role_name]'
     ],
     "defaults": {}
   }

**Response**

The response will return the updated node.

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
