=====================================================
Release Notes: Chef Automate
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/release_notes_chef_automate.rst>`__

Chef Automate provides a full suite of enterprise capabilities for workflow, visibility and compliance that allow you to manage and monitor application and cookbook deployments across a cluster of nodes in your environment.

What's New in 1.8.3
=====================================================

New Features
-----------------------------------------------------

* **Compliance Scanner and Job Scheduling (General Availability)**

  This month’s release extends your ability to assess and control the state of your system.

  We have expanded your ability to see your entire system with compliance scans of any node--even those not managed by Chef.

  We have added the ability to schedule recurring job scans using the Job Scheduling feature.

* **Compliance Search Date-Range Support**

  Control the start and end dates for displaying compliance scans from the search bar date picker.

* **The node’s platform version is now displayed in Compliance node lists**

* **LDAP authentication now supports simple_tls encryption**

Resolved Issues
-----------------------------------------------------

* Node scan history page now obeys profile filter set on Compliance dashboard
* Removed the sudo credentials option when creating or editing a node
* Fixed a race condition preventing the ‘updates available’ notification for Compliance profiles from being displayed
* Correctly displays platform versions in the Compliance nodes list
* Fixed missing input validation on Compliance UI
* Rubygems installed into Automate with an overly restrictive umask are now fixed when ``automate-ctl reconfigure`` is run
* Passwords and keys fields no longer display values when editing a credential
* The Compliance UI now displays a spinner when loading pages
* Scan jobs are now nested inside their parent job
* The date picker on the Compliance Reporting page now considers the ‘end of day’ in UTC
* The Compliance **Failed Nodes** icon now matches the node failure icon
* The Elasticsearch timeout during an ``automate-ctl reconfigure`` has been increased to 60 seconds
* Stale Elasticsearch lock files can be cleaned after a crash with ``automate-ctl delete-elasticsearch-lock --stale-lock-only``
* Fixed CA certificate path location on SuSE
* The data collector API now returns a 503 when Automate is in maintenance mode
* The Elasticsearch API now returns 400 if sent a HTML script tag to prevent XSS attacks

What's New in 1.7.114
=====================================================

New Features
-----------------------------------------------------

* **Compliance Scanner, Job Scheduling and Improvements (Beta)**

  This month’s release marks the addition of job scheduling to the compliance scanner and completes its core functionality. It allows for compliance scans to be scheduled for future or recurring runs. This enables users to fully automate their tests to run on a regular schedule.

  We have also improved the security of the secrets management system in the compliance scanner. It will no longer expose user secrets in the UI or API, and will instead retain them exclusively for internal calls to the compliance scanner. This increases the confidentiality of data while allowing the scanner to use secrets.

  The compliance scanner is in open beta as we continue to respond to user feedback before releasing it as generally available. To activate it, type ``beta`` anywhere in the UI and enable the feature in the popup that appears.

* **CIS Compliance Profile for Windows 2016**

  This release also features our new CIS Compliance Profile for Windows Server 2016. It contains subprofiles for the Member Server and Domain Controller, both in Level 1 and Level 2. They each feature up to 350 controls to help achieve compliance for modern Windows servers.

* **RHEL6 STIG Compliance Profile**

  The first set of STIG compliance profiles have been added to this release of Chef Automate. They include 261 controls for Red Hat Enterprise Linux 6 compliance. These controls also span category I - III and contain detailed information and references with every rule.

* **Performance Improvements for Compliance Profiles**

  Windows performance has been considerably improved with the release of `audit cookbook v6 <https://supermarket.chef.io/cookbooks/audit>`__, which leverages new mechanisms in InSpec and Train to speed up all tests. This is achieved with a caching approach that allows for considerably faster execution of all calls and resources on Microsoft Windows. On average, we found the CIS Windows benchmarks for execution time were reduced by 90%, allowing for a significant increase in speed. CIS for Linux benchmarks saw an average of 30% reduction in execution time.

  By default, caching is now enabled with audit cookbook v6. Please update it alongside Chef Automate and InSpec on your nodes to fully leverage these performance gains.

* **Performance Improvements for Compliance Reporting**

  Large environments with thousands of nodes provide great insights, but have been somewhat slow to load in Chef Automate due to the sheer amount of data that requires processing. In this release, we introduced a number of improvements to the backend that will make both API calls and the UI experience much faster for large environments.

  In the same cycle we improved the suggestions on all searches in Compliance Reporting. These now return more accurate results and have become noticeably faster.

* **Delete Runner Command**

  We’ve added the `delete-runner subcommand <https://docs.chef.io/runners.html#removing-a-runner>`__ to ``automate-ctl`` for easier management of runners used as part of a workflow pipeline.  Previously it was only possible to remove a runner by calling the ``delivery api``.

* **Data Retention Improvements for Reaper**

  Chef Automate’s Reaper feature for managing archives and deletion of Elasticsearch data now supports configuration of `distinct retention periods <https://docs.chef.io/data_retention_chef_automate.html>`__ for compliance and Chef Client run data.  As many organizations require that compliance data be stored for extended periods of time, this allows users to set the retention threshold without also requiring that Chef client run data be stored for the same period.

Resolved Issues
-----------------------------------------------------

* Fixed an issue that caused the umask check to incorrectly fail during the ``preflight-check``. The ``preflight-check`` currently checks on the return value of ``su -c 'umask' -l root`` and this can return values besides the raw ``int``  of the umask.
* After an upgrade of the Automate package in all versions up to and including 1.7.10, the user was previously encouraged to run ``automate-ctl setup``, which is unnecessary for an existing system. Now the user is prompted to run ``automate-ctl reconfigure``.
* Corrected an issue where Chef Automate only displayed up to 10 Chef Servers or organizations in the Nodes UI. All servers and orgs reporting data to Chef Automate are now visible and available for filtering.
* Resolved an issue with invalid JSON in the workflow Slack notifications, which was impacting webhook integration with Mattermost.
* Chef Automate’s Reaper now works in archive mode when using a non-default location for the archive repo. In previous releases Reaper archive mode only operated correctly when using the default repo path of ``/var/opt/delivery/elastisearch_backups``.
* Improved response time for ``automate-ctl help``.
* Improved the startup performance of Chef Automate by speeding up the Compliance service.
* The scanner no longer returns passwords via API calls.
* Compliance APIs have had their timestamps unified to `RFC3339 <https://www.ietf.org/rfc/rfc3339.txt>`__.
* RabbitMQ now listens on the loopback interface exclusively, and uses SSL for authentication and communication.
* Searching for nodes by attribute or resource now properly supports spaces and special characters.
* Testing a workflow runner from the Manage Runners page now correctly raises an error if the runner’s user account has an expired password.
* Installing a runner now works on CentOS/RHEL when the remote user does not have ``/usr/sbin`` in their ``PATH``.
* Installing a runner now works when the remote user’s shell is ``/bin/sh``.
* Installing a runner now defaults to collecting only the minimum required Ohai attributes to avoid potential issues with Ohai plugins. You must now pass the ``--full-ohai`` argument to ``automate-ctl install-runner`` to run all plugins on runner installation.

What's New in 1.7.39
=====================================================

New Features
-----------------------------------------------------

Removed Legacy Search Bar
++++++++++++++++++++++++++++++++++++++++++++++++++++
This release removes the legacy search bar from Automate. This search bar had been accessible under the Nodes tab via the ``legacy`` feature flag since release of Chef Automate 1.6.87 in August. With this release the legacy search bar has been removed from the product.

Resolved Issues
-----------------------------------------------------
* Security Fix: Removed RabbitMQ ``guest`` user. This change resolves a vulnerability that allowed remote access to the RabbitMQ data due to a system account with a weak default password.
* Corrected an issue preventing adding nodes via the user interface in the beta compliance scan jobs.
* Improved performance and stability of the compliance trend graph for larger data sets
* Removed remnants of unused ``census`` phone home component; backup jobs using the ``--no-census`` flag now returns an info-level warning because the flag is no longer required
* The 30 day trial license for cloud marketplace images is now correctly verified.

What's New in 1.7.27
=====================================================

Resolved Issues
-----------------------------------------------------

* The Compliance API endpoints experienced an unexpected move in their paths as part of the new compliance scanner being added in 1.7.10. These endpoint changes were reverted and the current API around ``/compliance/nodes`` is now available again. All scanner endpoints moved to the ``/compliance/scanner`` subpath instead.
* By default, the workflow functionality in Chef Automate would previously only connect to external services like Elasticsearch over SSL when the number of certificates in the chain was two or less. The default has been increased to 20.
* The ``automate-ctl install-runner`` command now works on nodes with an existing ``/etc/chef/validation.pem`` file.
* The ``nginx['use_implicit_hosts']`` setting now defaults to false to avoid edge cases on systems where we cannot detect the local IP addresses. It is recommended to set this to true if ``nginx['strict_host_header']`` is set to true for security reasons.
* The ``automate ctl data-summary`` command was reporting the total number of "converge" documents, which included started, completed and failed notifications. This has been modified to report only the total number of started runs.
* OpsWorks for Chef Automate and the cloud marketplace instances of Chef Automate rely on self-signed SSL certificates. As of Chrome 58, self-signed certificates with x509 version 3 without the SubjectAltName extension are invalid. We added the correct extension for the self-signed cert.
* Bitbucket integration now works with usernames containing the @ symbol.


What's New in 1.7.10
=====================================================

New Features
-----------------------------------------------------

Compliance Scanner Open Beta
++++++++++++++++++++++++++++++++++++++++++++++++++++
Previously, the only way to orchestrate remote InSpec runs was through the use of Chef Compliance, a standalone application which does not report data to Chef Automate. The compliance scanner, now available as an open beta feature in Chef Automate, allows you to add nodes and execute ad hoc remote compliance scans from within Chef Automate. In a future release we will add the ability to set up scheduled scan jobs.

Remote scans provide an important capability for any systems that may not have an agent installed, as well as for other endpoints and devices. The scanner, combined with existing reporting capabilities and profiles, offers a major enhancement to remote compliance testing with Chef Automate.

A few of the new features introduced:

* Add remote nodes with SSH and WinRM connections
* Add credentials for remote connections and sudo configuration
* Create jobs that execute ad hoc remote scans on all configured nodes
* View results in Chef Automate's compliance reporting view

To use the scanner please type ``beta`` from within the Chef Automate UI and enable the `compliance scanner feature </automate_compliance_scanner.html>`__.

Chef Automate Statistics
++++++++++++++++++++++++++++++++++++++++++++++++++++
The new ``automate-ctl data-summary`` command gives the total number of Chef client run records and compliance scan records, as well as how much storage is being consumed. For more information, see the `automate-ctl documentation </ctl_automate_server.html#data-summary>`__


Command Line Option for Reaper
++++++++++++++++++++++++++++++++++++++++++++++++++++
Override Reaper settings to run a manual Reaper job to remove data from Elasticsearch. Specify a retention period for a single reaper job from the command line. For more details, see `Data Retention Management in Chef Automate <https://docs.chef.io/data_retention_chef_automate.html>`__.

Removed Legacy Compliance Views
++++++++++++++++++++++++++++++++++++++++++++++++++++

The original compliance data views under the Nodes tab have been accessible via the ``legacy`` flag since the release of Chef Automate 1.5 in July.  With this release those views have been removed from the product, and data is no longer written to the underlying data indices.  Both historical and new compliance data is stored in new indices.  To remove the legacy data and reduce storage volume, see `Data Retention Management in Chef Automate <https://docs.chef.io/data_retention_chef_automate.html>`__.


Resolved Issues
-----------------------------------------------------

* Added `Nginx configuration option </config_rb_delivery_optional_settings.html#nginx>`__ to fix a security issue where an arbitrary host header could be passed and reflected in a subsequent redirect, which could potentially be used maliciously if a web cache was in use.
* LDAP authentication can now be configured to use anonymous bind
* Fixed a UI issue where the workflow change detail screen would scroll to the bottom, obscuring the Deliver button
* Fixed a UI issue where clicking on the view source window in compliance would close the window, making it impossible to copy its contents
* To address `CVE-2017-3526 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-3526>`__, server-jre has been updated to Java 8 Update 144
* To address `CVE-2017-8932 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-8932>`__, Golang has been updated to version 1.9.1

What's New in 1.6.179
=====================================================

New Features
-----------------------------------------------------

Notifications
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The beta period is complete and this feature is now generally available and enabled by default.  Chef Automate supports simple configuration of `Slack </integrate_node_notifications_slack.html>`_ or `webhook </integrate_node_notifications_webhook.html>`_ notifications for Chef client run failures and critical compliance control failures.

Authentication for External Elasticsearch
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Communication between Chef Automate and externally managed Elasticsearch clusters can now be configured to use SSL.  Additionally we have added `support for authentication </config_rb_delivery_optional_settings.html#elasticsearch>`_ through Elasticsearch X-Pack for external clusters.

Resolved Issues
-----------------------------------------------------

* Redesigned the CSV and JSON export for compliance data; it is now served from an API endpoint and can be used separate from the UI.  Previously the export omitted some records; it now includes all data, and accordingly the report may take more time to generate.
* Fixed an issue where upgrading Elasticsearch 5.x (during upgrade to Chef Automate 1.6.x) fails if there are incompatible configuration options for Elasticsearch 2.x specified in ``delivery.rb``
* Resolved an issue where ``automate-ctl delete-node`` was not removing nodes from the compliance UI
* Corrected a regression with the ``mark-nodes-missing`` script; nodes will now be set to missing if they have not checked in for 12 hours
* Upgraded Ruby to version 2.4.2 to address multiple CVEs


What's New in 1.6.99
=====================================================

This is a minor bug fix release. If you are upgrading from 1.5.x or earlier, please review the detailed upgrade notes for the 1.6.87 release for important upgrade information.

Resolved Issues
-----------------------------------------------------

* Fixed an issue that caused ``automate-ctl delete-node`` to fail with ``414 Request-URI Too Large``
* Fixed an issue that occurred on marketplace images (AWS and Azure) when a user tried to scan a node with the audit cookbook. A ``401 unauthorized`` error was returned when trying to use the “compliance” source for profiles. Until 1.6.99 is deployed to the marketplaces, you will need to upgrade images using ``marketplace-ctl upgrade``
* Changed logic on the **Test** button for webhook notifications to accept all ``2xx`` responses as successful

What's New in 1.6.95
=====================================================

This is a minor bug fix release. If you are upgrading from 1.5.x or earlier, please review the detailed upgrade notes for the 1.6.87 release for important upgrade information.

Resolved Issues
-----------------------------------------------------

* Fixed an issue where ``automate-ctl delete-node`` was returning 400 errors
* Fixed an issue where ``automate-ctl node-summary`` was returning 400 errors, and added UUID to the results returned by this command
* Removed the Environment and Role filter dropdowns from the Nodes page; these parameters have moved to the search bar on that page
* Resolved an issue from 1.6.87 where a backup/restore upgrade from 0.8.5 or earlier required additional migration steps for a subset of customers; these steps are no longer required if upgrading to this release

What's New in 1.6.87
=====================================================

.. note:: This release contains significant upgrades to the platform; please read these release notes carefully.  Before you upgrade to this release, please make a `complete backup  </delivery_server_backup.html#create-backups>`_ of your Chef Automate server.

Important Note when Upgrading from 0.8.5 or Earlier
-----------------------------------------------------

If you plan to upgrade to Chef Automate 1.6.87 by restoring a backup from an existing Chef Automate cluster that is running Chef Automate 0.8.5 or earlier, there is an additional step required to ensure that the Elasticsearch data can be restored and migrated to the new schema. If you are performing an in-place upgrade, you can disregard these instructions.

1. First, install the package and restore just the data archive.

   .. code-block:: bash

      rpm -Uvh automate-1.6.87-1.el7.x86_64.rpm
      automate-ctl restore-backup my-backup.zst

2. Next, delete the compliance-profiles alias.

   .. code-block:: none

      curl -X DELETE http://localhost:8080/elasticsearch/compliance-profiles/_alias/_all

3. Finally, restore the Elasticsearch snapshot.

   .. code-block:: bash

      automate-ctl restore-backup my-backup


New Features
-----------------------------------------------------

Elasticsearch 5 Upgrade
+++++++++++++++++++++++++++++++++++++++++++++++++++++

We’ve improved Chef Automate’s data handling resulting in a 20% decrease in on-disk index size for converge and compliance data going forward. The bundled version of Elasticsearch was upgraded from version 2.3 to 5.4.1 providing many `performance and resiliency benefits <https://www.elastic.co/blog/elasticsearch-5-0-0-released>`_.

Before you install this release, please make a `complete backup </delivery_server_backup.html#create-backups>`_ of your Chef Automate server.  Data will be migrated to new Elasticsearch indices as part of the reconfigure after installation; the process requires no user interaction.  After upgrading, note that backups made with version 1.6.87 cannot be restored to earlier versions of Chef Automate.

**Compatibility Notes**
If you are operating an external Elasticsearch cluster with Chef Automate, it must be upgraded to a 5.x version for compatibility with this release.

Kibana 5 Upgrade
+++++++++++++++++++++++++++++++++++++++++++++++++++++

Paired with the Elasticsearch upgrade, a matching Kibana version is a requirement for interoperability.  The upgrade to version 5.4.1 of Kibana in this release should have no material impact to Chef Automate’s functionality.  We are not upgrading Logstash at this time and Chef Automate will remain on version 2.x; customers using external ELK systems should ensure they also remain on Logstash 2.x.

Kibana is `no longer enabled by default </config_rb_delivery_optional_settings.html#kibana>`_ as of this release of Chef Automate.  Note that the newer version of Kibana requires additional memory, and we recommend allocating 2GB of RAM if you choose to enable it.

Additionally, if you have built custom dashboards with Kibana, they will be deleted as part of this upgrade.  Please *back up your dashboards* before applying this release of Chef Automate, and restore them when the upgrade is complete.  Before importing a custom dashboard, you will need to edit the exported JSON to change ``insights-*`` to ``[insights-]YYYY.MM.DD``.

Initial setup for Kibana after this upgrade:

#. Under “Index name or pattern”, change “logstash” to “insights”.
#. Select “@timestamp” for “Time-field name”.
#. Check the “Use event times to create index names [DEPRECATED]” checkbox.
#. Click **Create**.

Your screen should look like this before you click **Create**:

.. image:: ../../images/kibana_setup.png

Notifications -- Open Beta
+++++++++++++++++++++++++++++++++++++++++++++++++++++

We are delighted to invite all customers to participate in our open beta for notifications.  Chef Automate now supports simple configuration of `Slack </integrate_node_notifications_slack.html>`_ or `webhook </integrate_node_notifications_webhook.html>`_ notifications for Chef client run failures and critical compliance control failures.

To get started using notifications, navigate to the **Nodes** tab in Chef Automate and type ``beta`` anywhere in the UI.  The beta feature flag menu will allow you to toggle on the new notifications sub-tab in the nodes view.  We’d love to get your feedback -- please join us at https://chef-success.slack.com in the #automate-notification channel or visit feedback.chef.io.

Updated Compliance Profiles
+++++++++++++++++++++++++++++++++++++++++++++++++++++

All compliance profiles have been updated to include the build number of the profile. This change was necessary to track updates to CIS profiles which received changes without the official version number increasing. For example, a number of improvements were made to tests in the the RHEL profile family. Additionally, incorrectly formatted descriptions were updated and improved significantly.

CSV Export for Compliance Reports
+++++++++++++++++++++++++++++++++++++++++++++++++++++

In addition to the existing JSON export of compliance reports we have introduced the option to export a CSV file as well. The button in the top right corner of the compliance reporting view was updated to give the user the choice between exporting to JSON and exporting to CSV. In light of this change we also export node name information alongside node IDs.

Control Filter for Compliance
+++++++++++++++++++++++++++++++++++++++++++++++++++++

An additional filter was added to the search bar in the compliance reporting view. It allows users to search for specific controls and filter the view around these. In the past, it was only possible to search and filter the view around entire profiles, which didn’t cover cases where users asked for more fine-grained control.

.. note: This mechanism will filter the list of nodes and profiles but the summary information is still calculated for the entire node and profile, not just for the control.

Node Compliance View and History
+++++++++++++++++++++++++++++++++++++++++++++++++++++

This new view allows users to inspect the current and historic state of a node’s compliance assessment. In addition to the already included trendgraph, users can now see the node state and its entire scan history via the node view of all compliance reports.

New Search Bar on Nodes View
+++++++++++++++++++++++++++++++++++++++++++++++++++++

We’ve rebuilt the search bar on the Nodes view to be easier to use, and have added the ability to filter nodes by platform.  The original search bar will remain available under the `legacy` flag for three months.  Complete details on searching for nodes can be found in the `Node Search Query Reference </search_query_chef_automate.html>`_.  If you have trouble with the new search bar and find yourself continuing to use the legacy version, please contact us with your feedback.

Delete Node Improvements
+++++++++++++++++++++++++++++++++++++++++++++++++++++

There is now a ``delete-node`` subcommand for automate-ctl to delete a node and its corresponding history. This replaces ``delete-visibility-node``, which would remove the node from Chef Automate views but did not delete any data. For more information, see the `delete-node documentation </ctl_automate_server.html#delete-node>`_.

FIPS Support for Nginx
+++++++++++++++++++++++++++++++++++++++++++++++++++++

Chef Automate runs in a FIPS 140-2 compliant mode when the operating system kernel is configured similarly or when ``fips['enable'] = true`` is set in ``/etc/delivery/delivery.rb``.  When Chef Automate is configured for FIPS mode, this will also now configure Nginx to use the OpenSSL FIPS validated container.

Resolved Issues
-----------------------------------------------------

* Fixed an issue where ``automate-ctl install-runner`` was not prompting for a password
* The ``automate-ctl cleanse`` command has been fixed to behave as `documented </ctl_automate_server.html#cleanse>`_
* The Chef Automate UI no longer has issues when accessed through the IP address or anything not configured as its FQDN
* Fixed an issue that caused ``automate-ctl reconfigure`` to hang for several minutes when Chef’s product telemetry endpoint was not reachable
* Compliance scan results now display their latest timestamp
* Profile updates are now available from the profiles screen whenever a new version is released
* Fixed an issue that limited the list of compliance profiles in the report to 10
* Small UI fixes in the compliance view around scan results filter, profile suggestions, and reports with multiple scan results


What's New in 1.5.46
=====================================================

New Features
-----------------------------------------------------

Compliance GA
+++++++++++++++++++++++++++++++++++++++++++++++++++++

With this release, we are moving to a new view for InSpec data in Chef Automate. It provides better insights for common user queries around the compliance state of nodes and the state of profiles and their controls, with powerful search queries to see the right sets of data. After a beta period since the last release it is now the new default view for all compliance and InSpec data.

The previous **Compliance** sub-tab in the **Nodes** tab has been replaced with a new tab on the top-level navigation bar. This new **Compliance** tab provides access to both profiles and reporting capabilities.

We introduced this new compliance view during ChefConf 2017. `Check out the demo recording <https://www.youtube.com/watch?v=r7_f8fIn-Yo&feature=youtu.be&t=25m52s>`__ to see an earlier version of the features. For complete details on getting started, please visit `chef_automate_compliance`.

During the open beta, we improved a number of compliance capabilities:

* Migrated old data to the new compliance view. See the `data migration guide <https://docs.chef.io/upgrade_chef_automate.html#migrations>`_
* The trendgraph now displays the date of data in the tooltip
* Added a JSON download button for all reports in the UI
* Implemented faster profile installation
* Improved the Audit cookbook; please use Audit cookbook version 4.x
* Added support for ZIP profile upload

.. note:: If you need to continue using the previous compliance view, you can enable it easily. We have included a new feature flag to activate the old compliance view by typing ``legacy`` in the UI and toggling on this view in the menu.

All data that is received by Chef Automate will be available in both the new and old compliance view in our releases for the next 3 months, after which time the legacy view will be removed. Please reach out to us if you are unable to adopt the new view and are continuing to use the legacy compliance view, so we can understand in what way your needs are not met with the new view.

Chef Automate Pilot
+++++++++++++++++++++++++++++++++++++++++++++++++++++

This release introduces a Docker-based pilot offering for Chef Automate. This is specifically designed for customers evaluating Chef Automate for their organization, and is not intended for production use. The offering is built with Chef’s Habitat technology, allowing Chef Automate to be installed in a few minutes in containers running on a single machine. Also included are sets of compliance-driven demo data, to offer first-hand experience with the product. Customers can try the pilot by visiting https://www.chef.io/automate/ or https://www.chef.io/why-chef/. You can also go through the tutorial for Chef Automate Pilot on `Learn Chef Rally <https://learn.chef.io/modules/chef-automate-pilot/linux/docker#/>`_.

Policyfile Data Views
+++++++++++++++++++++++++++++++++++++++++++++++++++++

With this release, users can now see policyfile information associated with converge data and can search on policyfile arguments (policy name, policy group, and policy revision). The new policyfile data will populate on a going forward basis after you re-converge nodes and re-upload policy groups. While most data will start populating immediately, Chef client version 13.2 or 12.21.3 is required for some run list data to be available. Policyfile data is now shown in the node list, node header, node detail, and run list views of Chef Automate.

ChefDK 2.0 Support
+++++++++++++++++++++++++++++++++++++++++++++++++++++

Runners for workflow can now be installed using either ChefDK 1.x or ChefDK 2.0.  Note that because ChefDK 2.0 includes Chef client 13, customers should confirm their build cookbooks are compatible before upgrading runners.

Elasticsearch 5 Compatibility
+++++++++++++++++++++++++++++++++++++++++++++++++++++

This release of Chef Automate requires the Elasticsearch 2 API, and is fully compatible with both Elasticsearch 2 and Elasticsearch 5. Subsequent releases of Chef Automate will require Elasticsearch 5.

Tuning Options for Elasticsearch and Logstash
+++++++++++++++++++++++++++++++++++++++++++++++++++++

There are now more options to tune Chef Automate for best performance in your environment. Both Elasticsearch and Logstash now have additional ways to configure their resource utilization. For more information, see `delivery.rb Optional Settings </config_rb_delivery_optional_settings.html>`_.

Additional preflight checks
+++++++++++++++++++++++++++++++++++++++++++++++++++++

Before setup and configuration, you have the option of running the `automate-ctl preflight-check` subcommand. In this release, the parameters checked during preflight have been greatly expanded. For more information, see `Troubleshooting Preflight Check </troubleshooting_chef_automate.html#preflight-check>`_.

Resolved Issues
-----------------------------------------------------

* Fixed profile data aggregation for compliance meta-profiles. They would end up reporting all partial profiles which would result in an empty meta-profile report. The profile view now has aggregated data for the meta-profile for each node. In the future we will provide more insights into which profile dependency created what data in the output and what is overwritten by a wrapper.
* Fixed ``automate-ctl delete-visibility-node`` to work with compliance data. If a node is removed, all its compliance data will be removed as well. In future releases we will continue to improve node data lifecycle management.
* Fixed a number of calls that did not respect the user search in the Compliance view. Summary numbers were reported for nodes instead of the current search.
* Fixed compliance trendgraph data aggregation. If nodes didn't report within a data slot, you would not see any results in the trendgraph, which sometimes led to a line shaped like a wave. This is now corrected with every entry on the X axis showing the state of your fleet at that point aggregated from all previous information.
* Fixed a number of minor UI issues related to the compliance trendgraph, filtering, and reports
* In the **Nodes** tab, searching for nodes or attributes with uppercase letters in the name now returns correct results
* Security fix: zlib updated to 1.2.11
* Improved logging when ``automate-ctl install-runner`` fails executing knife commands
* Filters in the **Nodes** tab no longer apply results to radial graphs on the Welcome page
* Fixed an issue with misaligned text wrapping on node detail and run history pages
* In **Workflow**, the tables on the runners tab no longer redraw on page load
* In **Workflow**, under the **Review** tab, the expandable comments below a change in diff view will now display properly
* Default permissions for Chef Automate’s primary configuration file ``/etc/delivery/delivery.rb`` have been tightened from 0644 to 0640 so that the file is no longer world readable


What's New in 0.8.5
=====================================================

New Features
-----------------------------------------------------

Compliance in Chef Automate - Open Beta
+++++++++++++++++++++++++++++++++++++++++++++++++++++

With this release we have brought compliance capabilities into Chef Automate, without the need to install and operate a standalone compliance server. You can now manage InSpec compliance profiles in Chef Automate with features such as:

* Compliance profile installation and updates, when new versions become available
* 80 pre-shipped compliance profiles for all major operating systems
* View profiles, their metadata and controls, as well as InSpec code
* Search for profiles to view and install them
* Add custom profiles
* API endpoints to query profile contents

Additionally, we have significantly improved the reporting capabilities of Chef Automate for compliance:

* View data from a node-centric perspective to determine which components are out of compliance and what is needed to fix them
* View data from a profile-centric perspective to quickly assess compliance of your entire fleet with a specific profile, without the need to evaluate every node separately
* Investigate overall compliance control failures and determine which components are impacted
* Filter compliance reports by node, environment, profile, operating system, or platform
* View compliance reports with an overall summary and detailed information

To get started using compliance, install or upgrade to this release. Navigate to the **Nodes** tab in Chef Automate and type ``beta`` anywhere in the UI (not in a form field). The beta feature flag menu will allow you to toggle on the new compliance views. You can revert to the original view with compliance data as a sub-tab on the **Nodes** view by deactivating the beta feature flag.

.. note:: The beta views will display new data only. Historical data is displayed only in the existing sub-tab view under the **Nodes** page.

As you explore the beta, we welcome your feedback and invite you to visit `Chef’s Community Slack <http://community-slack.chef.io/>`__ and join our public #automate-compliance channel. You can also find `documentation </chef_automate_compliance.html>`__ about the features, including version requirements for InSpec and the Audit cookbook. The new compliance features are not recommended for production use until they are made generally available in an upcoming Chef Automate release.

SUSE Linux Enterprise Server Support
+++++++++++++++++++++++++++++++++++++++++++++++++++++

Chef Automate can now be installed on SUSE Linux Enterprise Server (SLES) 11 SP4 and 12 SP2 or above.


Resolved Issues
-----------------------------------------------------

* Corrected a bug with setting up cron jobs for creating backups on CentOS and Ubuntu.
* Added retries to RabbitMQ service on startup to correct a problem reported in OpsWorks for Chef Automate.
* Corrected a bug with failing to connect to Bitbucket when using a lengthy URL for the Bitbucket server.
* Corrected an issue with pagination when several pages of run history are displayed.


What's New in 0.7.239
=====================================================

Resolved Issues
-----------------------------------------------------

* The command automate-ctl backup-data has been removed. Please use automate-ctl create-backup in its place.
* Corrected an issue where users without root access could not use the --help command in automate-ctl.
* Updated users.rb to correct an issue of adding ‘git’ user in a tightly controlled user access environment.
* Added guarding to startup of the RabbitMQ service to avoid failures in cases where the network is not yet fully configured.
* Minor UI fixes (button colors, navigation breadcrumbs, incorrect favicon in Firefox browser).
* A newline as the first character in a delivery review title no longer renders an empty title in the Chef Automate workflow UI.
* A bug preventing users with an @ in their username from saving and sharing searches has been resolved.

What's New in 0.7.151
=====================================================

New Features
-----------------------------------------------------

Password Reset Token
+++++++++++++++++++++++++++++++++++++++++++++++++++++

There is a new ``automate-ctl`` command that issues a temporary token and URL to allow users to reset their passwords via the GUI as an alternative to an admin typing in the password via the ``automate-ctl reset-password`` command. The new command is documented `here </ctl_automate_server.html#generate-password-reset-token>`_.

Support for macOS Runners
+++++++++++++++++++++++++++++++++++++++++++++++++++++

Chef Automate can now support runners for workflow job dispatch on macOS 10.12. Installation follows the same `procedure </runners.html#adding-a-runner>`_ as Linux runners. Note that macOS is not a supported platform for the Chef Automate server.

Anonymized Usage Tracking
+++++++++++++++++++++++++++++++++++++++++++++++++++++

As of this release, Chef Automate will be able to send anonymized product usage data back to Chef. Chef will use that data to improve Chef Automate.

Server administrators are able to control data collection in Chef Automate on a per-server basis, via the `automate-ctl command-line application </ctl_automate_server.html>`_. If per-server data collection has been disabled, Chef Automate will not share any usage data with Chef from this server, or from any users who log into this server (regardless of their individual settings).

If per-server data collection is enabled, every person who logs into Chef Automate will be asked to decide if they want to share anonymized product usage data with Chef. No usage data will be collected until people have expressed this preference, by leaving a checkbox filled and closing a modal. By default, the preference will be to allow usage data collection, but no usage data is collected or shared until after the modal is dismissed.

The latest information about Chef’s data collection policies will always be available at https://www.chef.io/privacy-policy/.

Completion of UI Updates
+++++++++++++++++++++++++++++++++++++++++++++++++++++

The Chef Automate UI has gotten a refresh. We hope you enjoy the new look and feel.

Resolved Issues
-----------------------------------------------------

* Previous versions of Chef Automate did not correctly detect or support Oracle Enterprise Linux (OEL) for job runners.
* Improved detection and error messaging from preflight check when netstat is missing on CentOS systems.
* Navigating forward and backward through the converge history on nodes with several pages of historical data now works correctly.
* Saving and sharing searches in the nodes view now works correctly.
* The "About Automate" dialog box no longer defaults to appearing on every login until the checkbox is unset.

What's New in 0.7.85
=====================================================

New Features
-----------------------------------------------------

Preview of New UI
+++++++++++++++++++++++++++++++++++++++++++++++++++++

We are starting work to improve the look-and-feel of Chef Automate, so you will see some UI changes in the Nodes tab.

Configurable Elasticsearch snapshot timeouts
+++++++++++++++++++++++++++++++++++++++++++++++++++++

In cases where the Chef Automate Elasticsearch cluster has several hundred snapshots, the data deltas between snapshots are significant in size, and the snapshot repository is in S3, we've encountered cases where the default Faraday gem transport timeout of 60 seconds is too small which causes the snapshot utility to raise an error and fail. We've introduced configuration attributes for controlling the Faraday request timeout and the nginx Elasticsearch proxy timeouts. These have been bumped to 300 seconds by default, which should resolve this issue for most cases. Extremely busy Chef Automate clusters or instances with low I/O to S3 may need to bump them. It also increases the default timeout from 60 to 300. They can be configured in ``delivery.rb`` as follows:

.. code-block:: ruby

   elasticsearch['proxy_send_timeout'] = 300
   elasticsearch['proxy_read_timeout'] = 300
   backup['elasticsearch']['request_timeout'] = '300'

Bug Fixes
-----------------------------------------------------

Runners no longer install in FIPS mode when FIPS is not enabled
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Chef Automate 0.7.61, which shipped with FIPS 140-2 early access, would install all runners in FIPS mode, regardless of whether FIPS was enabled or not. This has now been corrected.

Run history now defaults to last 24h
+++++++++++++++++++++++++++++++++++++++++++++++++++++

Previously, Chef Automate would default to displaying run history data for the current day, cutting off at the prior midnight. Automate now defaults to displaying run history data for the past 24h instead.

Improved pre-flight-check memory detection
+++++++++++++++++++++++++++++++++++++++++++++++++++++

For operating systems reporting available memory in KB instead of GB, Chef Automate’s preflight check reported sufficient memory even though it did not meet the minimum requirements. This version of Chef Automate corrects the problem.

We encourage you to upgrade often. As always, we welcome your feedback and invite you to contact us directly or participate in our `feedback forum <https://feedback.chef.io/>`_. Thanks for using Chef Automate!

Opsworks: Chef Automate backups occasionally aren't deleted
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Occasionally the Chef Automate backup archives were not being deleted. This is likely due to the fact that retries and exponential retry backoff was only being used for upload S3 operations.

We've consolidated all S3 operations into the Backup::S3Client class which defaults to exponential backoff with five retries.

Automate backup lists are limited to 1000
+++++++++++++++++++++++++++++++++++++++++++++++++++++

The maximum response size when using the V2 S3 list objects API is 1000. We've added paging support for listing objects to support extremely rare cases where a user may have more than 1000 backups.

automate-ctl delete-backups exits with 0 if no match is found
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

We've changed the delete-backups command to exit with 1 when given a pattern.

What's New in 0.7.61
=====================================================

New Features
-----------------------------------------------------

Early Access: FIPS Support in Chef Automate
+++++++++++++++++++++++++++++++++++++++++++++++++++++

Chef Automate supports operating in FIPS mode for our government customers. Please contact us on fips-ea@chef.io for a copy of a FIPS-compatible ChefDK that supports interacting with the Chef Automate server in FIPS mode. General availability of both Chef Automate in FIPS mode and ChefDK will follow.

Outbound Proxy Support
+++++++++++++++++++++++++++++++++++++++++++++++++++++

Chef Automate now supports environments that require a web proxy for outbound network communication. This allows Chef Automate to be integrated with external SCM providers, such as GitHub, even in networks with rigorous security policies.

Changed Package Name to "automate"
+++++++++++++++++++++++++++++++++++++++++++++++++++++

This release includes a change to the Chef Automate install package name. For any customers who may have scripts or other automation expecting the package name to be “delivery”, please note you will need to update to "automate".
We have thoroughly tested the new package and expect the behavior to be consistent with the previous package; however, we strongly advise customers to back up their existing environment as a standard practice prior to installing a new release.

Other Improvements and Fixes
-----------------------------------------------------

Runner improvements: Logging and privilege escalation
+++++++++++++++++++++++++++++++++++++++++++++++++++++

Previous versions of Chef Automate would use the terms "Push Job started" even when using job runners, which are not push-job based. This misleading message has been rewritten. Additionally, when runner jobs failed, they would not supply enough information for users to understand why. Now, stderr and stdout from the failed job will be streamed to the workflow error log.
Runner installation will also no longer attempt to sudo if the user passed to install-runner is already root.

Bad error message if automate-ctl not run as root
+++++++++++++++++++++++++++++++++++++++++++++++++++++

``automate-ctl`` would throw a stack trace if it wasn't being run as root. This has now been corrected with an error message that indicates root privileges are needed.

Error Message running preflight-check
+++++++++++++++++++++++++++++++++++++++++++++++++++++

``preflight-check`` subcommand reports "system has less than 80GB disk space required at /var" even though the target installation directory does have sufficient disk space. This release fixed this error and will provide accurate feedback.

automate-ctl node-summary improvements
+++++++++++++++++++++++++++++++++++++++++++++++++++++

The ``node-summary`` subcommand produces a summary of the nodes that are known to Chef Automate. The default setting for ``node-summary`` is to display the name, status, and the last time the nodes were checked. `Read the docs </ctl_automate_server.html#node-summary>`_ for information.

Skip SSL verification for certain hosts
+++++++++++++++++++++++++++++++++++++++++++++++++++++

Chef Automate can now be configured to skip SSL certificate verification on a per-host basis. The ``delivery['no_ssl_verification']`` parameter can be set in the ``/etc/delivery/delivery.rb`` configuration to take a list of hosts to skip SSL verification. We generally do not recommend turning off SSL certificate verification in production environments, but this setting is useful for test environments where a correct certificate chain is not available.

Accessing Chef Automate by IP
+++++++++++++++++++++++++++++++++++++++++++++++++++++

The Chef Automate web UI can now be accessed by IP, which is useful in situations where the server's hostname is incorrect or not resolveable due to lack of DNS.

Fixed a bug that caused the UI to become unresponsive
+++++++++++++++++++++++++++++++++++++++++++++++++++++

In some cases the Chef Automate web UI was running into a timeout (especially in air-gapped environments). This was due to an external request for a font file, which is now packaged in the product and does not require Internet connectivity.

Allow use of uppercase characters in search filters
+++++++++++++++++++++++++++++++++++++++++++++++++++++

The Chef Automate UI now properly displays results from text filters that use uppercase characters.

What's New in 0.6.136
=====================================================

New Features
-----------------------------------------------------

SMTP credentials no longer required to send e-mail
+++++++++++++++++++++++++++++++++++++++++++++++++++++

In this release, the Username and Password fields in the SMTP server configuration are no longer required. This is a feature requested by users who have internal open relay mail servers on their network.

Other Improvements and Fixes
-----------------------------------------------------

Better logging when SSH fails as part of dispatching a workflow phase job
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
When dispatching a workflow phase job, any errors (example: sudo errors) are logged and displayed to the user.

Ensure passwords for runners are not logged in plaintext
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
If a runner was configured to use password authentication, the password would be displayed in plaintext in debug log files. This has now been corrected.

Improved presentation of debugging information in the “view error log” modal
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

This new view should make it much easier to quickly understand and correct problems with failed chef-client runs.

Compatibility with the latest Push Jobs Server
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

The latest version of Push Jobs Server (2.x) is now certified for use with Chef Automate. When using Push Jobs Server with Chef Automate, we recommend using the latest version. Existing installations of Chef Automate may upgrade their Push Jobs Server, but this is not required.

Minor fixes
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Corrected issue where nodes were being incorrectly marked as ‘missing’ when using an external Elasticsearch instance.

Improved error message when running ``automate-ctl`` commands that require root access.

What's New in 0.6.64
=====================================================

New Feature
-----------------------------------------------------

Chef Automate Pre-flight check
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

As part of the enhancements to improve Chef automate installation experience, a new optional command (automate-ctl preflight-check) is now available. You can now validate that a server meets the installation requirements of Chef Automate by running automate-ctl preflight-check. The command will check the target environment against installation requirements and advises if additional resources or adjustments are needed.

Resources validated includes: Memory, CPU, target directory structure, target directory disk space, umask, port access, and availability of SSH client.

Additional details on the command can be found at:
`pre-flight check reference </ctl_automate_server.html#preflight-check>`_
`troubleshooting information on pre-flight check </troubleshooting_chef_automate.html#preflight-check>`_
`Chef Automate Server Installation and Configuration </install_chef_automate.html#id2>`_

Other Improvements and Fixes
-----------------------------------------------------

More ``automate-ctl`` commands respond to --help.
Fixes a bug when using v2 runners that could result in duplicated Erlang processes.
Fixes an issue on automate-ctl install-runner that could have resulted in certificate validation failures.
