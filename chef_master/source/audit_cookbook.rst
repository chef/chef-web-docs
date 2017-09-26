Sending Compliance Data to Chef Automate with ``audit`` Cookbook
=======================================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/audit_cookbook.rst>`__


.. note:: The ``audit`` cookbook uses the InSpec gem. It will check for an installed version of InSpec and install it upon finding none. The latest version of InSpec will be installed by default unless otherwise specified with ``node['audit']['inspec_version']``.

:doc:`Cookbooks </cookbooks>` are Chef's primary unit of configuration management.  For tutorials on working with cookbooks in Chef, see `Learn Chef Rally <https://learn.chef.io>`_.
For more information specifically on using the ``audit`` cookbook with Automate, see :doc:`perform a compliance scan </perform_compliance_scan>`.

The ``Audit`` Cookbook
=================================
.. tag audit_cookbook_420

.. note:: Audit Cookbook version 4.2.0 or later requires InSpec 1.25.1 or later. You can upgrade your InSpec package in several different ways: by upgrading Automate, by upgrading the Chef Development Kit, by upgrading Chef Client, or by setting the ``node['audit']['inspec_version']`` attribute in your cookbook.

.. end_tag

To send compliance data gathered by InSpec as part of a Chef client run, you will need to use the `audit cookbook <https://github.com/chef-cookbooks/audit>`_. All profiles configured to run during the audit cookbook execution will send their results back to the Chef Automate server.

Configure the Node for ``audit`` Cookbook
---------------------------------------------
Once the cookbook is available in Chef Server, you will need to add the recipe to the run-list of each node. Compliance profiles are added using the ``node['audit']['profiles']`` attribute. A complete list of the possible configurations are documented in :doc:`Audit Cookbook </audit_cookbook>`.

To configure the audit cookbook to report compliance data directly to Chef Automate, you will first need to configure the Chef client to send node converge data, as described in :doc:`Data Collection </data_collection>`. Once you have done that, configure the audit cookbook's collector by setting the ``reporter``, ``server``, ``owner``, ``refresh_token`` and ``profiles`` attributes.

   * ``reporter`` - ``'chef-automate'`` to report to Chef Automate.
   * ``server`` - url of Chef Automate server with ``/api``.
   * ``owner`` - Chef Automate user or organization that will receive this scan report.
   * ``refresh_token`` - refresh token for Chef Automate API. Please note that logging out of the user interface revokes the ``refresh_token``. To workaround, log in once in a private browser session, grab the token and then close the browser without logging out.
   * ``insecure`` - a ``true`` value will skip the SSL certificate verification when retrieving an access token. The default value is ``false``.

A complete audit cookbook attribute configuration will look something like this:

   .. code-block:: ruby

      ['audit']['reporter'] = 'chef-automate'
      ['audit']['server'] = 'https://chef-automate-server/api'
      ['audit']['owner'] = 'my-comp-org'
      ['audit']['refresh_token'] = '5/4T...g=='
      ['audit']['insecure'] = false
      ['audit']['profiles'] = [
        {
         'name': 'windows',
         'compliance': 'base/windows'
         }
      ]

Instead of a refresh token, it is also possible to use a ``token`` that expires in 12h after creation.

  .. code-block:: ruby

     ['audit']['reporter'] = 'chef-automate'
     ['audit']['server'] =  'https://chef-automate-fqdn/api'
     ['audit']['owner'] =  'my-comp-org'
     ['audit']['token'] =  'eyJ........................YQ'
     ['audit']['profiles'] = [
        {
          'name': 'windows',
          'compliance': 'base/windows'
          }
      ]


Supported ``audit`` Cookbook Configurations
===================================================
The ``audit`` cookbook supports several different methods of fetching and reporting compliance information.

Fetch Directly From Compliance
-------------------------------------
.. list-table::
   :header-rows: 1

   * - Action
     - Configuration
   * - Fetch from Compliance and Report Directly to Automate
     - .. code-block:: ruby

         ['audit']['reporter'] = 'chef-automate'
         ['audit']['server'] = 'https://compliance-server.test/api'
         ['audit']['refresh_token' OR 'token'] = '..'
         ['audit']['owner'] = 'User/Org'
         #
         #Set in the client.rb:
         data_collector['server_url'] = 'https://chef-automate.test/data-collector/v0/'
         data_collector['token'] = '..'
   * - Fetch from Compliance and Report Directly to Compliance
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-compliance'
          ['audit']['server'] = 'https://compliance-server.test/api'
          ['audit']['refresh_token' OR 'token'] = '..'
          ['audit']['owner'] = 'User/Org'
   * - Fetch from Compliance and Report to Automate via Chef Server
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-server-automate'
          ['audit']['server'] = 'https://compliance-server.test/api'
          ['audit']['refresh_token' OR 'token'] = '..'
          ['audit']['owner'] = 'User/Org'
          #Set in chef-server.rb:
          data_collector['root_url'] = 'https://chef-automate.test/data-collector/v0/'
   * - Fetch from Compliance and Report to Compliance via Chef Server
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-server-compliance'
          ['audit']['server'] = 'https://compliance-server.test/api'
          ['audit']['refresh_token' OR 'token'] = '..'
          ['audit']['owner'] = 'User/Org'


Fetch From Compliance via Chef Server
---------------------------------------------------------
.. note:: Must have Compliance integrated with Chef Server

.. list-table::
   :header-rows: 1

   * - Action
     - Configuration
   * - Fetch From Compliance via Chef Server and Report Directly to Automate
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-automate'
          ['audit']['fetcher'] = 'chef-server'
          ['audit']['server'] = 'https://compliance-server.test/api'
          ['audit']['refresh_token' OR 'token'] = '..'
          ['audit']['owner'] = 'User/Org'
          #Set in client.rb:
          data_collector['server_url'] = 'https://chef-automate.test/data-collector/v0/'
          data_collector['token'] = '..'

   * - Fetch From Compliance via Chef Server and Report Directly to Compliance
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-compliance'
          ['audit']['fetcher'] = 'chef-server'
          ['audit']['server'] = 'https://compliance-server.test/api'
          ['audit']['refresh_token' OR 'token'] = '..'
          ['audit']['owner'] = 'User/Org'

   * - Fetch From Compliance via Chef Server and Report to Compliance via Chef Server
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-server-compliance'
          ['audit']['fetcher'] = 'chef-server'

   * - Fetch From Compliance via Chef Server and Report to Automate via Chef Server
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-server-automate'
          ['audit']['fetcher'] = 'chef-server'
          #Set in chef-server.rb:
          data_collector['root_url'] = 'https://chef-automate.test/data-collector/v0/'



Fetch From Automate via Chef Server
---------------------------------------------------------------------------

<<<<<<< HEAD
.. note:: Must have Compliance Integrated with Chef Server
=======
.. note:: Must have Compliance Integrated w/ Chef Server
>>>>>>> c7f5ab85dafa92ef07cb506be4edceb53b7977ff

.. list-table::
   :header-rows: 1

   * - Action
     - Configuration
   * - Fetch From Automate via Chef Server and Report Directly to Automate
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-automate'
          ['audit']['fetcher'] = 'chef-server'
          #Set in chef-server.rb:
          profiles['root_url'] = 'https://chef-automate.test'
          #Set in client.rb:
          data_collector['server_url'] = 'https://chef-automate.test/data-collector/v0/'
          data_collector['token'] = '..'
          #Set in delivery.rb:
          compliance_profiles["enable"] = true

   * - Fetch From Automate via Chef Server and Report Directly to Compliance
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-compliance'
          ['audit']['fetcher'] = 'chef-server'
          ['audit']['server'] = 'https://compliance-server.test/api'
          ['audit']['refresh_token' OR 'token'] = '..'
          ['audit']['owner'] = 'User/Org'
          # Set in chef-server.rb:
          profiles['root_url'] = 'https://automate-server.test'
          # Set in delivery.rb:
          compliance_profiles["enable"] = true

   * - Fetch From Automate via Chef Server and Report to Automate via Chef Server
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-server-compliance'
          ['audit']['fetcher'] = 'chef-server'
          #Set in chef-server.rb:
          data_collector['root_url'] = 'https://chef-automate.test/data-collector/v0/'
          profiles['root_url'] = 'https://chef-automate.test'
          #Set in delivery.rb: compliance_profiles["enable"] = true

   * - Fetch From Automate via Chef Server and Report to Compliance via Chef Server
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-server-compliance'
          ['audit']['fetcher'] = 'chef-server'
          #Set in chef-server.rb:
          profiles['root_url'] = 'https://chef-automate.test'
          #Set in delivery.rb: compliance_profiles["enable"] = true


Fetch From Automate via Chef Server
-------------------------------------------------------------------------------

.. list-table::
   :header-rows: 1

   * - Action
     - Configuration
   * - Fetch From Automate via Chef Server and Report Directly to Automate
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-automate'
          ['audit']['fetcher'] = 'chef-server'
          # chef-server.rb: profiles['root_url'] = 'https://chef-automate.test'
          # client.rb: data_collector['server_url'] = 'https://chef-automate.test/data-collector/v0/'
          data_collector['token'] = '..'
          # delivery.rb: compliance_profiles["enable"] = true

   * - Fetch From Automate via Chef Server and Report Directly to Compliance
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-compliance'
          ['audit']['fetcher'] = 'chef-server'
          ['audit']['server'] = 'https://compliance-server.test/api'
          ['audit']['refresh_token' OR 'token'] = '..'
          ['audit']['owner'] = 'User/Org'
          # chef-server.rb:
          profiles['root_url'] = 'https://chef-automate.test'
          # delivery.rb:
          compliance_profiles["enable"] = true

   * - Fetch From Automate via Chef Server and Report to Automate via Chef Server
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-server'
          ['audit']['fetcher'] = 'chef-server-automate'
          # chef-server.rb:
          data_collector['root_url'] = 'https://chef-automate.test/data-collector/v0/'
          profiles['root_url'] = 'https://chef-automate.test'
          # delivery.rb:
          compliance_profiles["enable"] = true

   * - Fetch From Automate via Chef Server and Report to Compliance via Chef Server (Must have Compliance integrated with Chef Server)
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-server-compliance'
          ['audit']['fetcher'] = 'chef-server'   #
          # chef-server.rb:
          profiles['root_url'] = 'https://chef-automate.test'
          # delivery.rb:
          compliance_profiles["enable"] = true
