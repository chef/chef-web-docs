.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Create a project cookbook. From the project's root directory, do the following:

#. Create a branch:

   .. code-block:: bash

      $ delivery checkout BRANCH_NAME

#. Generate a cookbook under ``/cookbooks`` in the project directory:

   .. code-block:: bash

      $ chef generate cookbook PROJECT_NAME

#. Review the ``metadata.rb`` file. It should be similar to:

   .. code-block:: ruby

      name 'my_project'
      maintainer 'The Authors'
      maintainer_email 'you@example.com'
      license 'all_rights'
      description 'Installs/Configures my_project'
      long_description 'Installs/Configures my_project'
      version '0.1.0'

   where ``version '0.1.0'`` must be changed if files within the cookbook change. The version number is what gets promoted through the stages in the |delivery| pipeline.
