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

      delivery_chef_server_search(:node, "key:attribute")

   or:

   .. code-block:: ruby

      delivery_chef_server_search(:node, 'query',
        :filter_result => { 'foo' => [ 'abc' ],
                            'bar' => [ '123' ],
                            'baz' => [ 'sea', 'power' ]
                          }
            ).each do |result|
        puts result['foo']
        puts result['bar']
        puts result['baz']
      end

   For example:

   .. code-block:: ruby

      delivery_chef_server_search(:node, 'role:load_balancer')

   or:

   .. code-block:: ruby

      delivery_chef_server_search(:node, 'platform:windows AND roles:postgresql')


``delivery_environment``
   Get the name of the standard environment.


``deployment_search_query``
   Get the search query from the ``config.json`` file.

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

   .. warning:: If the ``get_project_application`` method is called from the ``provision.rb`` recipe, be sure that ``delivery-truck::provision`` is executed before ``get_project_application`` by putting it in a ``ruby_block`` or into a separate recipe that is called from ``provision.rb`` via ``include_recipe``. If the ``get_project_application`` method is called directly in ``provision.rb``:

      .. code-block:: ruby

         include_recipe 'delivery-truck::provision'
         get_project_application(<project_app_name_string>)

      you will get an error because the |chef client| will execute ``get_project_application`` at compile time before it has run ``include_recipe 'delivery-truck::provision'``. It is recommended to either use ``get_project_application`` in ``deploy.rb``, a project cookbook, in a ``ruby_block`` or in a separate ``include_recipe`` that is executed after ``include_recipe 'delivery-truck::provision'``.

``get_project_secrets``
   Get the data bag from the |chef server| in which secrets used by this project are stored.

``has_kitchen_tests?``
   Determine if a |kitchen yml| file exists in a cookbook.

``has_spec_tests?``
   Determine if tests exist in the ``/spec`` directory in a cookbook.

``push_repo_to_github?``
   Determine if a repo should be pushed to |github|.

``upload_cookbook_to_chef_server?``
   Determine if a cookbook should be pushed to the |chef server|.
