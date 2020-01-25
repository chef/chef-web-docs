=====================================================
Integrate Workflow with SMTP
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/integrate_delivery_smtp.rst>`__

.. meta:: 
    :robots: noindex 

.. tag chef_automate_mark

.. image:: ../../images/a2_docs_banner.svg
   :target: https://automate.chef.io/docs

.. end_tag

.. tag EOL_a1

.. danger:: This documentation applies to a `deprecated product </versions.html#deprecated-products-and-versions>`__. Chef Automate includes newer out-of-the-box compliance profiles, an improved compliance scanner with total cloud scanning functionality, better visualizations, role-based access control and many other features. Chef Automate is included as part of the Workflow license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

.. end_tag

Workflow may be configured to allow projects to send email notifications to users about changes submitted to that project's pipeline, such as:

* A change passed verification
* A change was approved by a teammate
* A comment was added to the change request
* A change was accepted
* A change was delivered
* A change failed at a specific stage in the pipeline

Users may subscribe to notifications per project by using the **Watch Project** button located on each project's home page in the Workflow web UI.

Configure Notifications
=====================================================
To configure Workflow for SMTP notifications:

#. As an enterprise administrator on the Workflow server, select **Admin**.
#. Select the **Email Setup** tab in the web UI and complete the form:

   .. image:: ../../images/delivery_integrate_smtp.svg
      :width: 300px
      :align: left

#. Enter the URL for the SMTP server. For example: ``smtp.gmail.com``.
#. Enter the port number for the SMTP server. Most connections use port ``25`` by default. This setting will default to ``25`` if not specified.
#. Enter the SMTP server credentials---login and password---for the account from which mail is sent. For example: ``steved``, ``p@ssw0rd!``.
#. Optional. Enter the name for the sender from which mail is sent. For example: ``Steve Danno``.
#. Click the **Send Test** button. This will send an email to your email address, as specified in Workflow. The Workflow web UI will update the page if the email was sent successfully.

Subscribe to Notifications
=====================================================
Once an SMTP server is configured for Workflow, users that belong to that enterprise may subscribe to notifications that are sent from any project that exists in the same enterprise.

To subscribe to SMTP notifications:

#. Navigate to a project in Workflow.
#. Click the **Watch Project** button.
#. From the dropdown, select the categories of events for which notifications should be sent.

   The **Review** category enables notifications related to submitting, reviewing, and receiving feedback on a change.

   The **Deliver** category enables notifications related to changes that have passed acceptance (and may be delivered) or to changes that have been delivered.

   The **Observe** category enables notifications related to the status of the pipeline as changes move through it.

Unsubscribe from Notifications
=====================================================
A user may unsubscribe from notifications at any time.

#. Navigate to a project in Workflow.
#. Click the **Watch Project** button.
#. From the dropdown, de-select the categories of events for which notifications should no longer be sent. De-select all categories to stop receiving all notifications.
