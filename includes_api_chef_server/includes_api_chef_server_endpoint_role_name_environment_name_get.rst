.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method returns the environment-specific run-list (``env_run_lists[environment_name]``) for a role.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/NAME/roles/NAME/environments/NAME

where the first ``NAME`` is the name of the role and the second is the name of the environment.

**Response**

The response is similar to:

.. code-block:: javascript

    {"run_list":["recipe[foo]"]}

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
