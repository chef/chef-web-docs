.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


#. Open ``apache/.kitchen.yml``.
#. Add:

   .. code-block:: yaml
   
      ---
      driver:
        name: vagrant
      
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

#. Save the file.
