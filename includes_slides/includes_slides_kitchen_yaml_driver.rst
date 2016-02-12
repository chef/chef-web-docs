.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A driver specifies a virtualization or cloud provider by name:

.. code-block:: yaml

   ---
   driver:
     name: vagrant

.. code-block:: python

   provisioner:
     name: chef_zero
   
   platforms:
     - name: ubuntu-12.04
     - name: centos-6.4
   
   suites:
     - name: default
       run_list:
         - recipe[apache::default]
       attributes:
