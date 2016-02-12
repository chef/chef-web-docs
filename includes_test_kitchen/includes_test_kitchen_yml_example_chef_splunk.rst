.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following |kitchen yml| file is part of the ``chef-splunk`` cookbook and is used to help ensure the installation of the |splunk| client and server is done correctly.

.. code-block:: yaml

   driver:
     name: vagrant
     customize:
       memory: 512
   
   provisioner:
     name: chef_zero
   
   platforms:
     - name: ubuntu-10.04
     - name: ubuntu-12.04
     - name: centos-6.4
     - name: omnios-r151006c
       driver:
         box: omnios-r151006c
         box_url: http://omnios.omniti.com/media/OmniOS_r151006c-r1.box
   
   suites:
     - name: client
       run_list:
         - recipe[chef-splunk::default]
         - recipe[test::default]
       attributes:
         dev_mode: true
         splunk:
           accept_license: true
   
     - name: server
       run_list:
         - recipe[chef-splunk::default]
       attributes:
         dev_mode: true
         splunk:
           is_server: true
           accept_license: true
           ssl_options:
             enable_ssl: true
   
     - name: disabled
       run_list:
         - recipe[chef-splunk::default]
       attributes:
         splunk:
           disabled: true
   
     - name: upgrade_client
       run_list:
         - recipe[chef-splunk::default]
         - recipe[chef-splunk::upgrade]
       attributes:
         dev_mode: true
         splunk:
           accept_license: true
           upgrade_enabled: true
   
     - name: upgrade_server
       run_list:
         - recipe[chef-splunk::default]
         - recipe[chef-splunk::upgrade]
       attributes:
         dev_mode: true
         splunk:
           accept_license: true
           upgrade_enabled: true
           is_server: true
