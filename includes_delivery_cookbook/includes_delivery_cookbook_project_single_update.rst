.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Update a file in the project, and then update the version number in the ``metadata.rb`` file. This ensures this cookbook is promoted, overwriting the old project cookbook, and then updating the project across each stage of the |delivery| pipeline::

#. Check out the project from |delivery|:

   .. code-block:: bash

      $ delivery checkout master

#. Create a branch:

   .. code-block:: bash

      $ delivery checkout BRANCH_NAME

#. Edit the ``version`` in the ``metadata.rb`` file:

   .. code-block:: ruby

      version '0.2.0'

   and then make the desired changes.

#. Update to match the working tree:

   .. code-block:: bash

      $ git add -A

#. Add a commit message:

   .. code-block:: bash

      $ git commit -m "Updated our project's code to version 0.2.0."

#. Review the changes in |delivery|:

   .. code-block:: bash

      $ delivery review
