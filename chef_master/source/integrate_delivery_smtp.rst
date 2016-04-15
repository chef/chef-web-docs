.. THIS PAGE IS IDENTICAL TO docs.chef.io/integrate_delivery_smtp.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /delivery/ PATH.

=====================================================
Integrate Delivery with SMTP
=====================================================

|delivery| may be configured to allow projects to send email notifications to users about changes submitted to that project's pipeline, such as:

* A change passed verification
* A change was approved by a teammate
* A comment was added to the change request
* A change was accepted
* A change was delivered
* A change failed at a specific stage in the pipeline

Users may subscribe to notifications per project by using the **Watch Project** button located on each project's home page in the |delivery| web UI.

Configure Notifications
=====================================================
To configure |delivery| for |smtp| notifications:

#. As an enterprise administrator on the |delivery| server, select **Admin**.
#. Select the **Email Setup** tab in the web UI and complete the form:

   .. image:: ../../images/delivery_integrate_smtp.svg
      :width: 300px
      :align: left

#. Enter the URL for the |smtp| server. For example: ``smtp.gmail.com``.
#. Enter the port number for the |smtp| server. Most connections use port ``25`` by default. This setting will default to ``25`` if not specified.
#. Enter the |smtp| server credentials---login and password---for the account from which mail is sent. For example: ``steved``, ``p@ssw0rd!``.
#. Optional. Enter the name for the sender from which mail is sent. For example: ``Steve Danno``.
#. Click the **Send Test** button. This will send an email to your email address, as specified in |delivery|. The |delivery| web UI will update the page if the email was sent successfully.

Subscribe to Notifications
=====================================================
Once an |smtp| server is configured for |delivery|, users that belong to that enterprise may subscribe to notifications that are sent from any project that exists in the same enterprise.

To subscribe to |smtp| notifications:

#. Navigate to a project in |delivery|.
#. Click the **Watch Project** button.
#. From the dropdown, select the categories of events for which notifications should be sent.

   The **Review** category enables notifications related to submitting, reviewing, and receiving feedback on a change.

   The **Deliver** category enables notifications related to changes that have passed acceptance (and may be delivered) or to changes that have been delivered.

   The **Observe** category enables notifications related to the status of the pipeline as changes move through it.


Unsubscribe from Notifications
=====================================================
A user may unsubscribe from notifications at any time.

#. Navigate to a project in |delivery|.
#. Click the **Watch Project** button.
#. From the dropdown, de-select the categories of events for which notifications should no longer be sent. De-select all categories to stop receiving all notifications.
