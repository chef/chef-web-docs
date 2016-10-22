.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method returns the environment-specific run-list (``env_run_lists[environment_name]``) for a role.

This method has no parameters.

**Request**

.. code-block:: none

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
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.
