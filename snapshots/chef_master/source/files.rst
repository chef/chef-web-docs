=====================================================
About Files
=====================================================

Files are managed using the following resources:

   * Use the `cookbook_file <https://docs.chef.io/resource_cookbook_file.html>`_ resource to manage files that are added to nodes based on files that are located in the ``/files`` directory in a cookbook.
   * Use the `file <https://docs.chef.io/resource_file.html>`_ resource to manage files directly on a node.
   * Use the `remote_file <https://docs.chef.io/resource_remote_file.html>`_ resource to transfer files to nodes from remote locations.
   * Use the `template <https://docs.chef.io/resource_template.html>`_ resource to manage files that are added to nodes based on files that are located in the ``/templates`` directory in a cookbook.
