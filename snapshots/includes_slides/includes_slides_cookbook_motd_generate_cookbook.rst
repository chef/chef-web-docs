.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Run:

.. code-block:: bash

   $ chef generate cookbook motd

Returns:

.. code-block:: none

   Compiling Cookbooks...
     Recipe: code_generator::cookbook
       * directory[/home/chef/chef-repo/cookbooks/motd] action create
         - create new directory /home/chef/chef-repo/cookbooks/motd
       * template[/home/chef/chef-repo/cookbooks/motd/metadata.rb]
         action create_if_missing
         - create new file /home/chef/chef-repo/cookbooks/motd/metadata.rb
         - update content in file /home/chef/chef-repo/cookbooks/motd/metadata.rb
           from none to 7852c2
       * template[/home/chef/chef-repo/cookbooks/motd/README.md]
         action create_if_missing
     ...
