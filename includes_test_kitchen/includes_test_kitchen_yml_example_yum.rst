.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following |kitchen yml| file is part of the ``yum`` cookbook:

.. code-block:: yaml

   driver:
     name: vagrant
   
   provisioner:
     name: chef_zero
   
   platforms:
     - name: centos-5.11
     - name: centos-6.7
     - name: centos-7.2
     - name: fedora-22
   
   suites:
     - name: default
       run_list:
         - recipe[yum::default]
         - recipe[yum_test::test_repo]
     - name: dnf_compat
       run_list:
         - recipe[yum::dnf_yum_compat]
         - recipe[yum_test::test_dnf_compat]
       includes: fedora-22
