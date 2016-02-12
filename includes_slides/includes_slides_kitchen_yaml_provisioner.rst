.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A provisioner tells |kitchen| how to configure the node:

.. code-block:: python

   ---
   driver:
     name: vagrant

.. code-block:: yaml

   provisioner:
     name: chef_zero

.. code-block:: python

   platforms:
     - name: ubuntu-12.04
     - name: centos-6.4
   
   suites:
     - name: default
       run_list:
         - recipe[apache::default]
       attributes:
