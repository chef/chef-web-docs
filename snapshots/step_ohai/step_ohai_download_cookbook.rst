.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To download the ``ohai`` cookbook to the chef-repo run the following command:

.. code-block:: bash

   $ knife cookbook site install ohai

knife will return something similar to:

.. code-block:: bash

   INFO: Downloading ohai from the cookbooks site at version 0.9.0
   INFO: Cookbook saved: /Users/jtimberman/chef-repo/cookbooks/ohai.tar.gz
   INFO: Checking out the master branch.
   INFO: Checking the status of the vendor branch.
   INFO: Creating vendor branch.
   INFO: Removing pre-existing version.
   INFO: Uncompressing ohai version 0.9.0.
   INFO: Adding changes.
   INFO: Committing changes.
   INFO: Creating tag chef-vendor-ohai-0.9.0.
   INFO: Checking out the master branch.
   INFO: Merging changes from ohai version 0.9.0.
   [ ... SNIP ... ]
   INFO: Cookbook ohai version 0.9.0 successfully vendored!

