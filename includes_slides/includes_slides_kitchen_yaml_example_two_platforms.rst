.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Two platforms, one test suite:

.. code-block:: python

   ---
   driver:
     name: vagrant
   
   provisioner:
     name: chef_zero

.. code-block:: yaml

   platforms:
     - name: ubuntu-12.04
     - name: centos-6.4

.. code-block:: python

   suites:
     - name: default
       run_list:
         - recipe[apache::default]
