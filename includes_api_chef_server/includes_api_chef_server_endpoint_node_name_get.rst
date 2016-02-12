.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to return the details of a node as |json|.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/NAME/nodes/NAME

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name": "node_name",
     "chef_environment": "_default",
     "run_list": [
       "recipe[recipe_name]"
     ]
     "json_class": "Chef::Node",
     "chef_type": "node",
     "automatic": { ... },
     "normal": { "tags": [ ] },
     "default": { },
     "override": { } 
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