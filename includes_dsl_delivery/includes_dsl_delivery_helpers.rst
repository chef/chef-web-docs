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

``delivery_environment``
   Get the name of the standard environment.

``foodcritic_tags``
   Get a list of |foodcritic| tags that are applied to a node. This looks in the ``config.json`` file for the ``foodcritic`` block to see which rules should be included or excluded, and then returns the applicable tags.

   .. include:: ../../includes_delivery_config/includes_delivery_config_example_test_patterns.rst

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

``project_slug``
   Return a project slug.

``push_repo_to_github?``
   Determine if a repo should be pushed to |github|.

``upload_cookbook_to_chef_server?``
   Determine if a cookbook should be pushed to the |chef server|.
