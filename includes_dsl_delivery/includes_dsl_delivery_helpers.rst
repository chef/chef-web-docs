.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following |chef delivery|-specific helpers can be used in recipes:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Helper
     - Description
   * - ``bumped_version?``
     - Use to determine if files in a cookbook have been modified, and then to ensure that a cookbook's version is updated in its |metadata rb| file.
   * - ``changed_cookbooks``
     - Use to get a list of cookbooks that have been modified.
   * - ``changed_files``
     - Use to get a list of files that have been modified.
   * - ``delivery_chef_server``
     - Use to return a |ruby hash| that contains details about how to talk to the |chef server|.
   * - ``delivery_environment``
     - Use to get the name of the standard environment.
   * - ``foodcritic_tags``
     - Use to get the list of |foodcritic| tags that are applied to a node.
   * - ``get_acceptance_environment``
     - Use to get the name of the acceptance environment.
   * - ``get_project_secrets``
     - Use to get the data bag from the |chef server| in which secrets used by this project are stored.
   * - ``has_kitchen_tests?``
     - Use to determine if a |kitchen yml| file exists in a cookbook.
   * - ``has_spec_tests?``
     - Use to determine if tests exist in the ``/spec`` directory in a cookbook.
   * - ``project_slug``
     - Use to return a project slug.
   * - ``push_repo_to_github?``
     - Use to determine if a repo should be pushed to |github|.
   * - ``upload_cookbook_to_chef_server?``
     - Use to determine if a ookbook should be pushed to the |chef server|.
