.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following |kitchen yml| file sets up a simple |ha| configuration of |chef server oec|, including two front-end servers, a single back-end server, and all three add-ons (|push jobs|, |reporting|, and |chef manage|). The ``platforms`` block uses an ``attributes`` section to define |chef server|-specific attributes that are used by all three test suites:

.. code-block:: yaml

   ---
   driver:
     name: vagrant
   
   provisioner:
     name: chef_zero
   
   platforms:
     - name: ubuntu-12.04
       attributes:
         chef-server:
           api_fqdn: backend.chef-server.com
           backend:
             fqdn: backend.chef-server.com
             ipaddress: 123.456.789.0
           frontends:
             frontend1.chef-server.com: 123.456.789.0
             frontend2.chef-server.com: 123.456.789.0
           urls:
             private_chef: http://123.456.789.0/path/to/private-chef_11.1.4-1_amd64.deb
             manage: http://123.456.789.0/path/to/opscode-manage_1.3.1-1_amd64.deb
             reporting: http://123.456.789.0/path/to/opscode-reporting_1.1.1-1_amd64.deb
             push_jobs: http://123.456.789.0/path/to/opscode-push-jobs-server_1.1.1-1_amd64.deb
   
   suites:
     - name: frontend1
       driver:
         vm_hostname: frontend1.chef-server.com
         network:
         - ["private_network", {ip: "123.456.789.0"}]
         customize:
           memory: 2048
           cpus: 2
       run_list:
         - recipe[chef-server::configfile]
         - recipe[chef-server::ntp]
         - recipe[chef-server::server]
         - recipe[chef-server::frontend]
     - name: frontend2
       driver:
         vm_hostname: frontend2.chef-server.com
         network:
         - ["private_network", {ip: "123.456.789.0"}]
         customize:
           memory: 2048
           cpus: 2
       run_list:
         - recipe[chef-server::configfile]
         - recipe[chef-server::ntp]
         - recipe[chef-server::server]
         - recipe[chef-server::frontend]
     - name: backend
       driver:
         vm_hostname: backend.chef-server.com
         network:
         - ["private_network", {ip: "123.456.789.0"}]
         customize:
           memory: 8192
           cpus: 4
       run_list:
         - recipe[chef-server::configfile]
         - recipe[chef-server::ntp]
         - recipe[chef-server::server]
         - recipe[chef-server::backend]
