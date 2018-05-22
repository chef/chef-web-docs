=====================================================
Chef Client for Chef Analytics
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/chef_client_analytics.rst>`__

.. tag analytics_legacy

.. note:: This documentation is meant to support existing Chef customers using Analytics.

          If you are a new Chef customer, or are looking to gain better insight into your fleet, try `Chef Automate </chef_automate.html>`__. You'll get a graphical interface and query language that gives you insight into operational, compliance, and workflow events. Download Chef Automate `here <https://downloads.chef.io/automate>`__.


.. end_tag

This topic discusses the chef-client only from the context of Chef Analytics. For general information about the Chef client, see the `Chef Client Overview </chef_client_overview.html>`_.

audit-mode
=====================================================
.. tag chef_client_audit_mode

The chef-client may be run in audit-mode. Use audit-mode to evaluate custom rules---also referred to as audits---that are defined in recipes. audit-mode may be run in the following ways:

* By itself (i.e. a chef-client run that does not build the resource collection or converge the node)
* As part of the chef-client run, where audit-mode runs after all resources have been converged on the node

Each audit is authored within a recipe using the ``control_group`` and ``control`` methods that are part of the Recipe DSL. Recipes that contain audits are added to the run-list, after which they can be processed by the chef-client. Output will appear in the same location as the regular chef-client run (as specified by the ``log_location`` setting in the client.rb file).

Finished audits are reported back to the Chef server. From there, audits are sent to the Chef Analytics platform for further analysis, such as rules processing and visibility from the actions web user interface.

.. end_tag

Use following option to run the chef-client in audit-mode mode:

``--audit-mode MODE``
   Enable audit-mode. Set to ``audit-only`` to skip the converge phase of the chef-client run and only perform audits. Possible values: ``audit-only``, ``disabled``, and ``enabled``. Default value: ``disabled``.

New in Chef Client 12.1.

The Audit Run
-----------------------------------------------------
.. tag chef_client_audit_mode_run

The following diagram shows the stages of the audit-mode phase of the chef-client run, and then the list below the diagram describes in greater detail each of those stages.

.. image:: ../../images/audit_run.png

When the chef-client is run in audit-mode, the following happens:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Stages
     - Description
   * - **chef-client Run ID**
     - The chef-client run identifier is associated with each audit.
   * - **Configure the Node**
     - If audit-mode is run as part of the full chef-client run, audit-mode occurs after the chef-client has finished converging all resources in the resource collection.
   * - **Audit node based on controls in cookbooks**
     - Each ``control_group`` and ``control`` block found in any recipe that was part of the run-list of for the node is evaluated, with each expression in each ``control`` block verified against the state of the node.
   * - **Upload audit data to the Chef server**
     - When audit-mode mode is complete, the data is uploaded to the Chef server.
   * - **Send to Chef Analytics**
     - Most of this data is passed to the Chef Analytics platform for further analysis, such as rules processing (for notification events triggered by expected or unexpected audit outcomes) and visibility from the actions web user interface.

.. end_tag
