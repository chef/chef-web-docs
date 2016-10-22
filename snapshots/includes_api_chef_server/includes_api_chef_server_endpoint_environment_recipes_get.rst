.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to return a list of recipes available to a given environment.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/environments/NAME/recipes

where the first instance of ``NAME`` is the name of the environment, and the second instance is the name of the recipe.

**Response**

The response is similar to:

.. code-block:: none

   [
     "ant",
     "apache2",
     "apache2::mod_auth_openid",
     "apache2::mod_authnz_ldap",
     "apt",
     "aws",
     "capistrano",
     "chef",
     "chef::bootstrap_client",
     "chef-client::config",
     "chef-client",
     ...
   ]

The list of recipes will be the default recipes for a given cookbook. If an environment has multiple versions of a cookbook that matches its constraints, only the recipes from the latest version of that cookbook will be reported.

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
