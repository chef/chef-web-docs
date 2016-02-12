.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following |kitchen yml| file shows how to configure settings related to |busser|:

.. code-block:: yaml

   driver:
     name: vagrant

   busser:
     plugins:
       - plugin@1.2.3
       - ...

   provisioner:
     name: chef_zero
   
   platforms:
     - name: centos-5.10
     - name: ...

   suites:
   
   - name: service_init
     run_list:
     - recipe[minitest-handler]
     - recipe[chef-client::config]
     - recipe[chef-client_test::service_init]
     - recipe[chef-client::init_service]
     attributes: {}
   
   - name: suite_name
     ...

where:

* ``busser:`` is a block that describes the configuration used for |busser| by |kitchen|
* ``plugins:`` is a list of dependencies
* ``'plugin@1.2.3'`` is application name and version;, separated by ``@``

For example:

.. code-block:: yaml

   driver:
     name: vagrant

   busser:
     plugins:
       - serverspec@0.2.0
       - rspec@0.7.4
       - minitest
   
   provisioner:
     name: chef_zero
   
   platforms:
     - name: centos-5.10
     - name: ...

   suites:
   
   - name: service_init
     run_list:
     - recipe[minitest-handler]
     - recipe[chef-client::config]
     - recipe[chef-client_test::service_init]
     - recipe[chef-client::init_service]
     attributes: {}
   
   - name: suite_name
     ...


.. commenting out the following, which represents one of the proposed ways of configuring busser
.. https://github.com/test-kitchen/test-kitchen/issues/515
.. saving for "just in case"
.. 
.. .. code-block:: yaml
.. 
..    driver:
..      name: vagrant
.. 
..    busser:
..      version: busser@1.2.3
..      root_path: /var/tmp/kitchen-busser
..      ruby_bindir: /opt/local/bin
..      plugins: ['app_A@1.2.3', 'app_B@1.2.3', ...]
.. 
..    provisioner:
..      name: chef_zero
..    
..    platforms:
..      - name: centos-5.10
..        ...
..        busser: busser-alternate@1.2.3
..      - name: ...
.. 
..    suites:
..    
..    - name: service_init
..      run_list:
..      - recipe[minitest-handler]
..      - recipe[chef-client::config]
..      - recipe[chef-client_test::service_init]
..      - recipe[chef-client::init_service]
..      attributes: {}
..    
..    - name: suite_name
..      ...
.. 
.. where:
.. 
.. * ``busser:`` is a block that describes the configuration used for |busser| by |kitchen|
.. * ``busser@1.2.3`` is the version of |busser|
.. * ``plugins:`` is an array of dependencies
.. * ``'app_A@1.2.3'``, ``'app_B@1.2.3'``, and so is a comma-separated array that defines each dependency by application name and version; use ``x`` for the version to allow dependencies on any version
.. * ``busser-alternate@1.2.3`` is a platform-specific version of |busser|
.. 
.. For example:
.. 
.. .. code-block:: yaml
.. 
..    driver:
..      name: vagrant
.. 
..    busser:
..      version: busser@0.9.0rc2
..      root_path: /var/tmp/kitchen-busser
..      ruby_bindir: /opt/local/bin
..      plugins: ['serverspec@0.2.6', 'minitest@x', 'bats@x', 'rspec@x']
..    
..    provisioner:
..      name: chef_zero
..    
..    platforms:
..      - name: centos-5.10
..      - name: ...
.. 
..    suites:
..    
..    - name: service_init
..      run_list:
..      - recipe[minitest-handler]
..      - recipe[chef-client::config]
..      - recipe[chef-client_test::service_init]
..      - recipe[chef-client::init_service]
..      attributes: {}
..    
..    - name: suite_name
..      ...
.. 
.. 