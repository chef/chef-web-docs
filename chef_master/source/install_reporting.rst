=====================================================
Install Reporting
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_reporting.rst>`__

.. tag reporting_legacy

.. note:: This documentation is meant to support existing Chef customers using Reporting.

          Are you a new Chef customer, or looking to gain better insight into your fleet? Take advantage of `Chef Automate <https://www.chef.io/automate/>`__. You'll get a graphical interface and query language that gives you insight into operational, compliance, and workflow events. You can `try out Chef Automate here <https://automate.chef.io/docs/quickstart/>`__.

.. end_tag

.. tag reporting_summary

Use Reporting to keep track of what happens during the execution of chef-client runs across all of the machines that are under management by Chef. Reports can be generated for the entire organization and they can be generated for specific nodes.

Reporting data is collected during the chef-client run and the results are posted to the Chef server at the end of the chef-client run at the same time the node object is uploaded to the Chef server.

.. end_tag

.. note:: .. tag chef_subscriptions

          This feature is included as part of the Chef Automate license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

          .. end_tag

Requirements
=====================================================
.. tag system_requirements_reporting

Reporting has the following minimum requirements:

* Chef server 12
* chef-client version 11.6.0 (or later)

Reporting can make use of an external database, but to do so Reporting 1.5.5 or later is needed along with Chef server 12.2.0 or later.

The Reporting client is built into the chef-client and can run on all platforms that chef-client is supported on.

.. warning:: Reporting does not work on chef-client version 11.8.0; upgrade to chef-client version 11.8.2 (or later) if Reporting is being run in your organization.

.. warning:: The only supported versions of Reporting are 1.5.5 or later.

.. end_tag

Install the Server
=====================================================

Standalone
-----------------------------------------------------
To set up the Reporting server:

#. Install the package on the Chef server:

   .. code-block:: bash

      $ chef-server-ctl install opscode-reporting

#. Reconfigure the Chef server:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Complete the installation:

   .. code-block:: bash

      $ opscode-reporting-ctl reconfigure

   .. note:: .. tag chef_license_reconfigure_reporting

             Starting with Reporting 1.6.0, the `Chef MLSA </chef_license.html>`__ must be accepted when reconfiguring the product. If the Chef MLSA has not already been accepted, the reconfigure process will prompt for a ``yes`` to accept it. Or run ``opscode-reporting-ctl reconfigure --accept-license`` to automatically accept the license.

             .. end_tag

#. Verify the installation:

   .. code-block:: bash

      $ opscode-reporting-ctl test

Chef HA
-----------------------------------------------------
Reporting is not compatible with Chef high availability.

Install the Client
=====================================================
Reporting is automatically enabled in the chef-client (version 11.6.0 or later). In order to check if reporting data is being sent, you can check the output of the chef-client ``INFO`` logging level for the log message confirming the data has been sent. At the end of the chef-client run:

.. code-block:: bash

   $ chef-client -l info
   ...
   ...
   [date] INFO: Chef Run complete in 1.069059018 seconds
   [date] INFO: Running report handlers
   [date] INFO: Report handlers complete
   Chef Client finished, 2 resources updated
   [date] INFO: Sending resource update report (run-id: 51ceb817-ba7e-47e5-9bca-096fe9ef9740)

This includes the run identifier of the chef-client run, which can be used in the `knife reporting plugin </plugin_knife_reporting.html>`__ or the Chef management console to access the reporting information generated during the chef-client run.

Install the Workstation
=====================================================
To set up the Reporting workstation, install the `knife reporting plugin </plugin_knife_reporting.html>`__. Once
installed, the following subcommands will be available: ``knife runs list``, ``knife runs show``.
