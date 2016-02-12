.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``POST`` method is used to create a new node.

This method has no parameters.

**Request**

.. code-block:: xml

   POST /organizations/NAME/nodes

with a request body similar to:

.. code-block:: javascript

   {
     "name": "latte",
     "chef_type": "node",
     "json_class": "Chef::Node",
     "attributes": {
       "hardware_type": "laptop"
     },
     "overrides": {},
     "defaults": {},
     "run_list": [ "recipe[unicorn]" ]
   }

where ``name`` is the name of the node. Other attributes are optional. The order of the ``run_list`` attribute matters.

**Response**

The response is similar to:

.. code-block:: javascript

   { "uri": "https://localhost/nodes/latte" }

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
