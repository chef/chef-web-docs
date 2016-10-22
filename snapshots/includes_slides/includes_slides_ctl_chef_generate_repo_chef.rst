.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Run:

.. code-block:: bash

   $ chef generate repo chef-repo

Returns:

.. code-block:: none

   Compiling Cookbooks...
     Recipe: code_generator::repo
       * directory[/home/chef/chef-repo] action create
         - create new directory /home/chef/chef-repo
         - restore selinux security context
       * template[/home/chef/chef-repo/LICENSE] action create
         - create new file /home/chef/chef-repo/LICENSE
         - update content in file /home/chef/chef-repo/LICENSE
           from none to dbc1af
         - restore selinux security context
       * cookbook_file[/home/chef/chef-repo/README.md] action create
         - create new file /home/chef/chef-repo/README.md
         - update content in file /home/chef/chef-repo/README.md
           from none to 767ead
         - restore selinux security context
       * cookbook_file[/home/chef/chef-repo/Rakefile] action create
