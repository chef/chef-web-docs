=======================================================================
Sending Compliance Data to Chef Automate with Audit Cookbook
=======================================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/audit_cookbook.rst>`__

.. meta::
    :robots: noindex

.. note:: The ``audit`` cookbook uses the Chef InSpec gem. It will check for an installed version of Chef InSpec and install it upon finding none. The latest version of Chef InSpec will be installed by default unless otherwise specified with ``node['audit']['inspec_version']``.

`Cookbooks </cookbooks.html>`__ are Chef's primary unit of configuration management.  For tutorials on working with cookbooks in Chef, see `Learn Chef Rally <https://learn.chef.io>`__.

Audit Cookbook
=================================
.. note:: Audit Cookbook version 4.2.0 or later requires Chef InSpec 1.25.1 or later. You can upgrade your Chef InSpec package in several different ways: by upgrading Automate, by upgrading the ChefDK, by upgrading Chef Infra Client, or by setting the ``node['audit']['inspec_version']`` attribute in your cookbook.



To send compliance data gathered by Chef InSpec as part of a Chef Infra Client run, you will need to use the `audit cookbook <https://github.com/chef-cookbooks/audit>`_. All profiles configured to run during the audit cookbook execution will send their results back to the Chef Automate server.

Configure the Node for Audit Cookbook
---------------------------------------------
Once the cookbook is available in Chef Infra Server, you will need to add the ``audit::default`` recipe to the run-list of each node. Compliance profiles are added using the ``node['audit']['profiles']`` attribute. A complete list of the configurations is documented on GitHub in the `Audit Cookbook Repository <https://github.com/chef-cookbooks/audit/blob/master/README.md>`__.

To configure the audit cookbook to report compliance data directly to Chef Automate, you will first need to configure Chef Infra Client to send node converge data, as described in `Data Collection </data_collection.html>`__. Next, configure the audit cookbook collector by setting the ``reporter``, ``server``, ``owner``, ``refresh_token`` and ``profiles`` attributes.

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


Supported Audit Cookbook Configurations
===================================================
The ``audit`` cookbook supports several different methods of fetching and reporting compliance information.

.. tag EOL_compliance_server

.. warning:: The standalone Chef Compliance server is deprecated. The standalone Chef Compliance server's end-of-life date is December 31, 2018. `Chef Automate 2 <https://automate.chef.io/>`__ has all of the functionality of Chef Compliance Server and also includes newer out-of-the-box compliance profiles, an improved compliance scanner with total cloud scanning functionality, better visualizations, role-based access control and many other features not found in Chef Compliance Server.

.. end_tag

Fetch From Automate via Chef Infra Server
---------------------------------------------------------------------------

.. note:: The Compliance server must be integrated with Chef Infra Server for use in reporting.

.. list-table::
   :header-rows: 1

   * - Action
     - Configuration
   * - Fetch From Automate via Chef Infra Server and Report Directly to Automate
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

   * - Fetch From Automate via Chef Infra Server and Report Directly to Compliance
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

   * - Fetch From Automate via Chef Infra Server and Report to Automate via Chef Infra Server
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-server-automate'
          ['audit']['fetcher'] = 'chef-server'
          #Set in chef-server.rb:
          data_collector['root_url'] = 'https://chef-automate.test/data-collector/v0/'
          profiles['root_url'] = 'https://chef-automate.test'
          #Set in delivery.rb:
          compliance_profiles["enable"] = true

   * - Fetch From Automate via Chef Infra Server and Report to Compliance via Chef Infra Server
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-server-compliance'
          ['audit']['fetcher'] = 'chef-server'
          #Set in chef-server.rb:
          profiles['root_url'] = 'https://chef-automate.test'
          #Set in delivery.rb:
          compliance_profiles["enable"] = true

Fetch From Compliance via Chef Infra Server
---------------------------------------------------------
.. note:: The Compliance server must be integrated with Chef Infra Server for use in reporting.

.. list-table::
   :header-rows: 1

   * - Action
     - Configuration
   * - Fetch From Compliance via Chef Infra Server and Report Directly to Automate
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-automate'
          ['audit']['fetcher'] = 'chef-server'
          ['audit']['server'] = 'https://compliance-server.test/api'
          ['audit']['refresh_token' OR 'token'] = '..'
          ['audit']['owner'] = 'User/Org'
          #Set in client.rb:
          data_collector['server_url'] = 'https://chef-automate.test/data-collector/v0/'
          data_collector['token'] = '..'

   * - Fetch From Compliance via Chef Infra Server and Report Directly to Compliance
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-compliance'
          ['audit']['fetcher'] = 'chef-server'
          ['audit']['server'] = 'https://compliance-server.test/api'
          ['audit']['refresh_token' OR 'token'] = '..'
          ['audit']['owner'] = 'User/Org'

   * - Fetch From Compliance via Chef Infra Server and Report to Compliance via Chef Infra Server
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-server-compliance'
          ['audit']['fetcher'] = 'chef-server'

   * - Fetch From Compliance via Chef Infra Server and Report to Automate via Chef Infra Server
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-server-automate'
          ['audit']['fetcher'] = 'chef-server'
          #Set in chef-server.rb:
          data_collector['root_url'] = 'https://chef-automate.test/data-collector/v0/'

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
   * - Fetch from Compliance and Report to Automate via Chef Infra Server
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-server-automate'
          ['audit']['server'] = 'https://compliance-server.test/api'
          ['audit']['refresh_token' OR 'token'] = '..'
          ['audit']['owner'] = 'User/Org'
          #Set in chef-server.rb:
          data_collector['root_url'] = 'https://chef-automate.test/data-collector/v0/'
   * - Fetch from Compliance and Report to Compliance via Chef Infra Server
     - .. code-block:: ruby

          ['audit']['reporter'] = 'chef-server-compliance'
          ['audit']['server'] = 'https://compliance-server.test/api'
          ['audit']['refresh_token' OR 'token'] = '..'
          ['audit']['owner'] = 'User/Org'
