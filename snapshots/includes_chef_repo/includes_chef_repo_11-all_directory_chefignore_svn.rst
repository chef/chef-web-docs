.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


If Subversion is being used as the version source control application, it is important not to upload certain files that Subversion uses to maintain the version history of each file. This is because the chef-client will never use it while configuring nodes, plus the amount of data in an upload that includes top-level Subversion data could be significant.

To prevent the upload of top-level Subversion data, add something like the following to the chefignore file:

.. code-block:: none

   */.svn/*

To verify that the top-level Subversion data is not being uploaded to the Chef server, use knife and run a command similar to:

.. code-block:: bash

   $ knife cookbook show name_of_cookbook cookbook_version | grep .svn

