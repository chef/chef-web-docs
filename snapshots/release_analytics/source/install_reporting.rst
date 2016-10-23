.. THIS PAGE IS LOCATED AT THE /release/analytics/ PATH.

=====================================================
Install Reporting
=====================================================

.. include:: ../../includes_reporting/includes_reporting.rst

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst

Requirements
=====================================================
.. include:: ../../includes_system_requirements/includes_system_requirements_reporting.rst

Install the Server
=====================================================
.. include:: ../../includes_install/includes_install_reporting_ha.rst

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

This includes the run identifier of the chef-client run, which can be used in the `knife reporting plugin <https://docs.chef.io/plugin_knife_reporting.html>`_ or the Chef management console to access the reporting information generated during the chef-client run.

Install the Workstation
=====================================================
To set up the Reporting workstation, install the `knife reporting plugin <https://docs.chef.io/plugin_knife_reporting.html>`_. Once
installed, the following subcommands will be available: ``knife runs list``, ``knife runs show``.
