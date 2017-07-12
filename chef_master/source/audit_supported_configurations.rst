=====================================================
Supported Configurations in ``audit`` Cookbook
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/audit_supported_configurations.rst>`__

The ``audit`` cookbook supports several different methods of fetching and reporting compliance information.

Fetch Directly From Compliance
=====================================

Report Directly to Compliance
----------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-compliance'
   ['audit']['server'] = 'https://compliance-server.test/api'
   ['audit']['refresh_token' OR 'token'] = '..'
   ['audit']['owner'] = 'User/Org'

Report Directly to Automate
----------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-automate'
   ['audit']['server'] = 'https://compliance-server.test/api'
   ['audit']['refresh_token' OR 'token'] = '..'
   ['audit']['owner'] = 'User/Org'
   #Set in the client.rb:
   data_collector['server_url'] = 'https://automate-server.test/data-collector/v0/'
   data_collector['token'] = '..'

Report to Compliance via Chef Server
----------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-server-compliance'
   ['audit']['server'] = 'https://compliance-server.test/api'
   ['audit']['refresh_token' OR 'token'] = '..'
   ['audit']['owner'] = 'User/Org'

Report to Automate via Chef Server
----------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-server-automate'
   ['audit']['server'] = 'https://compliance-server.test/api'
   ['audit']['refresh_token' OR 'token'] = '..'
   ['audit']['owner'] = 'User/Org'
   #Set in chef-server.rb:
   data_collector['root_url'] = 'https://automate-server.test/data-collector/v0/'

Fetch From Compliance via Chef Server
=====================================
Report Directly to Compliance
----------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-compliance'
   ['audit']['fetcher'] = 'chef-server-automate'
   ['audit']['server'] = 'https://compliance-server.test/api'
   ['audit']['refresh_token' OR 'token'] = '..'
   ['audit']['owner'] = 'User/Org'

.. note:: Must have Compliance Integrated w/ Chef Server

Report Directly to Automate
----------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-automate'
   ['audit']['fetcher'] = 'chef-server-automate'
   ['audit']['server'] = 'https://compliance-server.test/api'
   ['audit']['refresh_token' OR 'token'] = '..'
   ['audit']['owner'] = 'User/Org'
   #Set in client.rb:
   data_collector['server_url'] = 'https://automate-server.test/data-collector/v0/'
   data_collector['token'] = '..'

.. note: Must have Compliance Integrated w/ Chef Server

Report to Compliance via Chef Server
----------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-server-compliance'
   ['audit']['fetcher'] = 'chef-server-automate'

.. note:: Must have Compliance Integrated w/ Chef Server

Report to Automate via Chef Server
----------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-server-automate'
   ['audit']['fetcher'] = 'chef-server-automate'
   #Set in chef-server.rb:
   data_collector['root_url'] = 'https://automate-server.test/data-collector/v0/'

.. note:: Must have Compliance Integrated w/ Chef Server


Fetch From Automate via Chef Server
=====================================
Report Directly to Compliance
----------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-compliance'
   ['audit']['fetcher'] = 'chef-server-automate'
   ['audit']['server'] = 'https://compliance-server.test/api'
   ['audit']['refresh_token' OR 'token'] = '..'
   ['audit']['owner'] = 'User/Org'
   #Set in chef-server.rb:
   profiles['root_url'] = 'https://automate-server.test'
   #Set in delivery.rb:
   compliance_profiles["enable"] = true

Report Directly to Automate
----------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-automate'
   ['audit']['fetcher'] = 'chef-server-automate'
   #Set in chef-server.rb:
   profiles['root_url'] = 'https://automate-server.test'
   #Set in client.rb:
   data_collector['server_url'] = 'https://automate-server.test/data-collector/v0/'
   data_collector['token'] = '..'
   #Set in delivery.rb:
   compliance_profiles["enable"] = true

Report to Compliance via Chef Server
----------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-server-compliance'
   ['audit']['fetcher'] = 'chef-server-automate'
   #Set in chef-server.rb:
   profiles['root_url'] = 'https://automate-server.test'
   #Set in delivery.rb:
   compliance_profiles["enable"] = true

.. note:: Must have Compliance Integrated w/ Chef Server

Report to Automate via Chef Server
----------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-server-automate'
   ['audit']['fetcher'] = 'chef-server-automate'
   #Set in chef-server.rb:
   data_collector['root_url'] = 'https://automate-server.test/data-collector/v0/'
   profiles['root_url'] = 'https://automate-server.test'
   #Set in delivery.rb:
   compliance_profiles["enable"] = true
