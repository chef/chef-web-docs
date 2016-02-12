.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to return the ``run_list`` attribute of the role (when the name of the environment is ``_default``) or to return ``env_run_lists[environment_name]`` (for non-default environments).

.. note:: The behavior of this endpoint is identical to ``GET /roles/NAME/environments/NAME``; it is recommended (but not required) that ``GET /roles/NAME/environments/NAME`` be used instead of this endpoint.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/NAME/environments/NAME/roles/NAME

where the first instance of ``NAME`` is the name of the environment, and the second instance is the name of the role.

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "run_list": [
       "recipe[recipe_name]",
       "role[role_name]",
       "recipe[recipe_name]",
       "role[role_name]",
       "recipe[recipe_name]",
       "role[role_name]"
     ]
   }

The |chef client| will pick up the ``_default`` run-list if ``env_run_list[environment_name]`` is null or nonexistent.

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
