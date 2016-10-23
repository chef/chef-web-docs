.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Using a maximum version control strategy is required when everything needs to be tracked in source control. This approach is very similar to a branch tracking strategy while the cookbook is in development and being tested, but is more complicated and time-consuming (and requires file-level editing for environment data) in order to get the cookbook deployed to a production environment.

The typical workflow with a maximum version control strategy includes:

#. Bumping the version number as appropriate.
#. Making changes to a cookbook.
#. Uploading and testing a cookbook.
#. Moving a tested cookbook to production.

For example, to bump a version number, first make changes to the cookbook, and then upload and test it. Repeat this process as required, and then upload it using a knife command similar to:

.. code-block:: bash

   $ knife cookbook upload my-app

When the cookbook is finished, move those changes to the production environment and use the ``--freeze`` option to prevent others from making further changes:

.. code-block:: bash

   $ knife cookbook upload  my-app -E production --freeze

Then modify the environment so that it prefers the newly uploaded version:

.. code-block:: bash

  (vim|emacs|mate|ed) YOUR_REPO/environments/production.rb

Upload the updated environment:

.. code-block:: bash

   $ knife environment from file production.rb

And then deploy the new cookbook version.
