.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``DELETE`` method is used to delete an environment.

This method has no parameters.

**Request**

.. code-block:: xml

   DELETE /organizations/NAME/environments/NAME

**Response**

The response will return the |json| for the environment that was deleted, similar to:

.. code-block:: javascript

   {
     "name":"backend",
     "description":"",
     "cookbook_versions":{},
     "json_class":"Chef::Environment",
     "chef_type":"environment",
     "default_attributes":{},
     "override_attributes":{}
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