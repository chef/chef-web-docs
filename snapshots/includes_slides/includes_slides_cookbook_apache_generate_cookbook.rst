.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Run:

.. code-block:: bash

   $ chef generate cookbook apache

Returns:

.. code-block:: none

   Compiling Cookbooks...
   Recipe: code_generator::cookbook
     * directory[/home/chef/chef-repo/cookbooks/apache] action create
       - create new directory /home/chef/chef-repo/cookbooks/apache
       - restore selinux security context
     * template[/home/chef/chef-repo/cookbooks/apache/metadata.rb] action
       create_if_missing
       - create new file /home/chef/chef-repo/cookbooks/apache/metadata.rb
       - update content in /home/chef/chef-repo/cookbooks/apache/metadata.rb
         from none to 4c0e2d
       - restore selinux security context
     * template[/home/chef/chef-repo/cookbooks/apache/README.md] action
       create_if_missing
       - create new file /home/chef/chef-repo/cookbooks/apache/README.md
    ...
