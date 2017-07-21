=====================================================
Supported Configurations in ``audit`` Cookbook
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/audit_supported_configurations.rst>`__

The ``audit`` cookbook supports several different methods of fetching and reporting compliance information.

Fetch Directly From Compliance
===========================================

Fetch from Compliance and Report Directly to Automate
-------------------------------------------------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-automate'
   ['audit']['server'] = 'https://compliance-server.test/api'
   ['audit']['refresh_token' OR 'token'] = '..'
   ['audit']['owner'] = 'User/Org'
   #
   #Set in the client.rb:
   data_collector['server_url'] = 'https://chef-automate.test/data-collector/v0/'
   data_collector['token'] = '..'

Fetch from Compliance and Report Directly to Compliance
-----------------------------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-compliance'
   ['audit']['server'] = 'https://compliance-server.test/api'
   ['audit']['refresh_token' OR 'token'] = '..'
   ['audit']['owner'] = 'User/Org'

Fetch from Compliance and Report to Automate via Chef Server
-------------------------------------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-server-automate'
   ['audit']['server'] = 'https://compliance-server.test/api'
   ['audit']['refresh_token' OR 'token'] = '..'
   ['audit']['owner'] = 'User/Org'
   #Set in chef-server.rb:
   data_collector['root_url'] = 'https://chef-automate.test/data-collector/v0/'

Fetch from Compliance and Report to Compliance via Chef Server
-------------------------------------------------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-server-compliance'
   ['audit']['server'] = 'https://compliance-server.test/api'
   ['audit']['refresh_token' OR 'token'] = '..'
   ['audit']['owner'] = 'User/Org'

Fetch From Compliance via Chef Server
==================================================
Fetch From Compliance via Chef Server and Report Directly to Automate
------------------------------------------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-automate'
   ['audit']['fetcher'] = 'chef-server'
   ['audit']['server'] = 'https://compliance-server.test/api'
   ['audit']['refresh_token' OR 'token'] = '..'
   ['audit']['owner'] = 'User/Org'
   #Set in client.rb:
   data_collector['server_url'] = 'https://chef-automate.test/data-collector/v0/'
   data_collector['token'] = '..'

.. note: Must have Compliance Integrated w/ Chef Server

Fetch From Compliance via Chef Server and Report Directly to Compliance
--------------------------------------------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-compliance'
   ['audit']['fetcher'] = 'chef-server'
   ['audit']['server'] = 'https://compliance-server.test/api'
   ['audit']['refresh_token' OR 'token'] = '..'
   ['audit']['owner'] = 'User/Org'

.. note:: Must have Compliance Integrated w/ Chef Server

Fetch From Compliance via Chef Server and Report to Compliance via Chef Server
-------------------------------------------------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-server-compliance'
   ['audit']['fetcher'] = 'chef-server'

.. note:: Must have Compliance Integrated w/ Chef Server

Fetch From Compliance via Chef Server and Report to Automate via Chef Server
-----------------------------------------------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-server-automate'
   ['audit']['fetcher'] = 'chef-server'
   #Set in chef-server.rb:
   data_collector['root_url'] = 'https://chef-automate.test/data-collector/v0/'

.. note:: Must have Compliance Integrated w/ Chef Server


Fetch From Automate via Chef Server
==================================================
Fetch From Automate via Chef Server and Report Directly to Automate
---------------------------------------------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-automate'
   ['audit']['fetcher'] = 'chef-server'
   #Set in chef-server.rb:
   profiles['root_url'] = 'https://chef-automate.test'
   #Set in client.rb:
   data_collector['server_url'] = 'https://chef-automate.test/data-collector/v0/'
   data_collector['token'] = '..'
   #Set in delivery.rb:
   compliance_profiles["enable"] = true

Fetch From Automate via Chef Server and Report Directly to Compliance
----------------------------------------------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-compliance'
   ['audit']['fetcher'] = 'chef-server'
   ['audit']['server'] = 'https://compliance-server.test/api'
   ['audit']['refresh_token' OR 'token'] = '..'
   ['audit']['owner'] = 'User/Org'
   #
   # Set in chef-server.rb:
   profiles['root_url'] = 'https://automate-server.test'
   #
   # Set in delivery.rb:
   compliance_profiles["enable"] = true

Fetch From Automate via Chef Server and Report to Automate via Chef Server
-----------------------------------------------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-server-compliance'
   ['audit']['fetcher'] = 'chef-server'
   #Set in chef-server.rb:
   data_collector['root_url'] = 'https://chef-automate.test/data-collector/v0/'
   profiles['root_url'] = 'https://chef-automate.test'
   #Set in delivery.rb:
   compliance_profiles["enable"] = true

Fetch From Automate via Chef Server and Report to Compliance via Chef Server
-------------------------------------------------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-server-compliance'
   ['audit']['fetcher'] = 'chef-server'
   #Set in chef-server.rb:
   profiles['root_url'] = 'https://chef-automate.test'
   #Set in delivery.rb:
   compliance_profiles["enable"] = true

.. note:: Must have Compliance Integrated w/ Chef Server

Fetch From Automate via Chef Server
==========================================

Fetch From Automate via Chef Server and Report Directly to Automate
-------------------------------------------------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-automate'
   ['audit']['fetcher'] = 'chef-server'
   #
   # chef-server.rb:
   profiles['root_url'] = 'https://chef-automate.test'
   #
   # client.rb:
   data_collector['server_url'] = 'https://chef-automate.test/data-collector/v0/'
   data_collector['token'] = '..'
   #
   # delivery.rb:
   compliance_profiles["enable"] = true

Fetch From Automate via Chef Server and Report Directly to Compliance
-------------------------------------------------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-compliance'
   ['audit']['fetcher'] = 'chef-server'
   ['audit']['server'] = 'https://compliance-server.test/api'
   ['audit']['refresh_token' OR 'token'] = '..'
   ['audit']['owner'] = 'User/Org'
   #
   # chef-server.rb:
   profiles['root_url'] = 'https://chef-automate.test'
   #
   # delivery.rb:
   compliance_profiles["enable"] = true

Fetch From Automate via Chef Server and Report to Automate via Chef Server
-------------------------------------------------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-server'
   ['audit']['fetcher'] = 'chef-server-automate'
   # chef-server.rb:
   data_collector['root_url'] = 'https://chef-automate.test/data-collector/v0/'
   profiles['root_url'] = 'https://chef-automate.test'
   #
   # delivery.rb:
   compliance_profiles["enable"] = true

Fetch From Automate via Chef Server and Report to Compliance via Chef Server
-------------------------------------------------------------------------------
.. code-block:: ruby

   ['audit']['reporter'] = 'chef-server-compliance'
   ['audit']['fetcher'] = 'chef-server'
   #
   # chef-server.rb:
   profiles['root_url'] = 'https://chef-automate.test'
   #
   # delivery.rb:
   compliance_profiles["enable"] = true
   #
   # NOTE: Must have Compliance Integrated w/ Chef Server
