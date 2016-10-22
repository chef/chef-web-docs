.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Using a branch tracking strategy requires that a branch for each environment exists in the source control and that each cookbook's versioning policy is tracked at the branch level. This approach is relatively simple and lightweight: for development environments that track the latest cookbooks, just bump the version before a cookbook is uploaded for testing. For any cookbooks that require higher levels of version control, knife allows cookbooks to be uploaded to specific environments and for cookbooks to be frozen (which prevents others from being able to make changes to that cookbook).

The typical workflow with a branch tracking version control strategy includes:

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
