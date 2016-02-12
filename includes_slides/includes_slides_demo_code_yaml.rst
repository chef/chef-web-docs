.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Some |yaml|:

.. code-block:: yaml

   ---
   section:
     property: value
     etc...

For example, |kitchen yml| file with two platforms and one test suite:

.. code-block:: yaml

   ---
   driver:
     name: vagrant
   
   provisioner:
     name: chef_zero
   
   platforms:
     - name: ubuntu-12.04
   
   suites:
     - name: default
       run_list:
         - recipe[apache::default]
