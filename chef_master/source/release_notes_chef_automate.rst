=====================================================
Release Notes: Chef Automate
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/release_notes_chef_automate.rst>`__

Chef Automate provides a full suite of enterprise capabilities for workflow, visibility and compliance that allow you to manage and monitor application and cookbook deployments across a cluster of nodes in your environment.

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

As you explore the beta, we welcome your feedback and invite you to visit `Chef’s Community Slack <http://community-slack.chef.io/>`_ and join our public #automate-compliance channel. You can also find :doc:`documentation </chef_automate_compliance>` about the features, including version requirements for InSpec and the Audit cookbook. The new compliance features are not recommended for production use until they are made generally available in an upcoming Chef Automate release.

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

Chef Automate now supports environments that require a web proxy for outbound network communication. This allows Chef Automate to be integrated with external SCM providers, such as Github, even in networks with rigorous security policies.

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