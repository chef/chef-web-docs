=====================================================
Scanner
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/automate_compliance_scanner.html>`__

.. tag beta_note

This feature is in ``beta`` release. To access this feature, place your cursor anywhere on an Automate page, type ``beta`` and enable the feature.

.. end_tag

.. note:: Credentials are required to perform a compliance scan. See `Credentials <automate_compliance_credentials.html>`__.

Create ad-hoc scan and scheduled scan jobs of your system with the Chef Automate Compliance Scanner. Creating scan jobs is through the user interface allows you to target specific nodes with compliance profiles. From the Compliance Scanner view you can add and delete both nodes and jobs from the system.

.. image:: ../../images/automate_scanner_jobs.png

Add Nodes
==============================================
From the Automate Compliance Scanner view select the **Add Nodes** button, which will open a form titled "Enter node detals to add nodes".

.. image:: ../../images/automate_add_node.png

#. Enter the Public DNS or Public IP for the nodes separated by a comma or space into the first field, titled "Import multiple nodes by IP or hostname." Nodes will appear in the "Preview" section, which is on the right side of the form, as they are entered. (Required)
#. Add an optional a prefix tag to the nodes created using this form. Prefixes are reusable and can assist in retrieving groups of nodes that have a shared prefix. (Optional) 
#. In the "Add credentials to connect your nodes" section of the form, select either the type of credential, either SSH or WinRm, that you will use to connect to your nodes. (Reqiured)
#. Select credentials fthat you will use to access your nodes. If you need to add a new credential, select the "Add new credentials" text, which will direct you to the **Credentials** view. Navigating away from the **Add Nodes** view will result in the loss of unsaved nodes.(Required)
#. Customize the default port access setting, if needed. (Optional)
#. Disable the ``sudo`` setting, if needed. (Optional)
#. Select the **Add Nodes** button above the form button to finish adding nodes. This  button changes to display the number of nodes added. 

Return to the Overview page and move to the **Nodes** view to examine your new nodes. These nodes are now available for use with jobs, and can be edited and deleted.

Create a Job
-------------------------------------------------
If you have not already added compliance profiles to your user account from the **Profile Store** or by uploading custom profiles, you will need to move to the **Profile Store** to complete this step. If you leave the **Credentials** view, you will lose any unsaved data.

.. image:: ../../images/automate_scanner_job_create.png

#. Select the **Create New Job** button to make a new scan job.
#. From the **Scan Job Creation** form, enter a name for your new job.
#. Select one or more nodes that will be scanned in this job from the list of nodes.
#. Select one or more profiles to run against the nodes.
#. Select the **Save** button to finish creating the scan job.

Jobs
-------------------------------------------------
View and delete scan job results.

.. image:: ../../images/automate_scanner_jobs.png

* **Jobs:** Scan jobs are listed by name and can be sorted alphabetically
* **Node Count:** The number of nodes assigned to the scan job.
* **Last Scan:** Time elapsed since the scan job was last run and can be sorted chronologically.
* **Status:** The scan job is either not yet run, running, completed, or failed. ``failed`` means that the job could not run on the selected nodes. Scans can be sorted by job status.
* **Report:** Compliance report allows view your compliance report filtered by the selected scan job. For more information, see `Reporting <automate_compliance_reporting.html>`__.
* **Delete** the job.

Nodes 
-------------------------------------------------

.. image:: ../../images/automate_scanner_nodes.png

* **Nodes:** The name of the node and any prefix assigned to it. Nodes can be sorted alphabetically.
* **Platform:** The platform running on the node, such as Amazon Linux, RHEL, SUSE, Ubuntu, or Windows. Platforms can be sorted alphabetically.
* **Status:** The node is either reachable or unreachable. Nodes can be sorted by status.
* **Edit:** Rename, add nodes, and change credentials.
* **Delete** the node.
