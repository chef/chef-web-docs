.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following |delivery|-specific helpers can be used in recipes:

``bumped_version?``
   Determine if files in a cookbook have been modified, and then to ensure that a cookbook's version is updated in its |metadata rb| file.

``changed_cookbooks``
   Get a list of cookbooks that have been modified.

``changed_files``
   Get a list of files that have been modified.

``define_project_application``
   Define a set of attributes that are used to pin versions as the project moves through stages in the |delivery| pipeline.

``delivery_chef_server``
   Return a |ruby hash| that contains details about how to talk to the |chef server|.


``delivery_chef_server_search``
   Run a search query against the node objects on the |chef server|, using standard |chef server| search query syntax with the index type set to ``:node``, similar to:

   .. code-block:: ruby

      delivery_chef_server_search('key:attribute')

   For example:

   .. code-block:: ruby

      delivery_chef_server_search('role:load_balancer')

   or:

   .. code-block:: ruby

      delivery_chef_server_search('platform:windows AND roles:postgresql')


``delivery_environment``
   Get the name of the standard environment.


``deployment_search_query``
   Get a custom search query from the ``config.json`` file. By default, the ``deploy.rb`` recipe triggers a |chef client| run via |push jobs| against all nodes that belong to the current environment in |delivery| and have modified cookbooks in the run-list.

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_deploy_search_query.rst

``foodcritic_excludes``
   Get a list of directories against which |foodcritic| rules should not be run. This looks in the ``config.json`` file for the ``foodcritic`` block to see if the ``excludes`` setting has been specified.

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_lint_foodcritic_excludes.rst

``foodcritic_tags``
   Get a list of |foodcritic| tags (rule identifiers) to be run. This looks in the ``config.json`` file for the ``foodcritic`` block to see if the ``only_rules`` and/or ``ignore_rules`` settings have been specified.

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_lint_foodcritic_ignore_rules.rst

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_lint_foodcritic_only_rules.rst

``get_acceptance_environment``
   Get the name of the acceptance environment.

``get_project_application``
   Get attributes for a defined project application.

   .. warning:: .. include:: ../../includes_dsl_delivery/includes_dsl_delivery_helpers_get_project_application_warning.rst

``get_project_secrets``
   Get the contents of data bag from the |chef server|, in which secrets for project are stored.

``has_kitchen_tests?``
   Determine if a |kitchen yml| file exists in a cookbook.

``has_spec_tests?``
   Determine if tests exist in the ``/spec`` directory in a cookbook.

``push_repo_to_git?``
   Determine if a repo should be pushed to an open source |git| repository.

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_publish_git.rst

``push_repo_to_github?``
   Determine if a repo should be pushed to |github|.

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_publish_github.rst

``share_cookbook_to_supermarket?``
   Determine if a repo should be pushed to an open source |git| repository.

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_publish_supermarket.rst

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_publish_supermarket_private.rst

``upload_cookbook_to_chef_server?``
   Determine if a cookbook should be pushed to the |chef server|.

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_publish_chef_server.rst

``use_custom_supermarket_credentials``

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_publish_supermarket_credentials.rst