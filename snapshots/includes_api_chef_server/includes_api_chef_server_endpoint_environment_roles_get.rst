.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to return the ``run_list`` attribute of the role (when the name of the environment is ``_default``) or to return ``env_run_lists[environment_name]`` (for non-default environments).

.. note:: The behavior of this endpoint is identical to ``GET /roles/NAME/environments/NAME``; it is recommended (but not required) that ``GET /roles/NAME/environments/NAME`` be used instead of this endpoint.

This method has no parameters.

**Request**

.. code-block:: none

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

The chef-client will pick up the ``_default`` run-list if ``env_run_list[environment_name]`` is null or nonexistent.

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
