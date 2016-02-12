.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|chef analytics| can be configured to send event notifications by email.

.. note:: |chef analytics| must be able to connect to an SMTP server on the configured port. Ensure that your network is configured correctly before proceeding.

#. To begin, log in to |chef analytics| and click on the **Notifications** tab.

#. Next, click on the **+** button, then click on **Email**.

   .. image:: ../../images/analytics_email_new_notification.png

   The **Email Notification** form will appear.

#. Enter a name for your notification by clicking on the field to the right of **Email Notification:**.

   .. image:: ../../images/analytics_email_notification_create_form.png

#. Fill out the required fields, as well as the **Username** and **Password** fields if your SMTP server requires authentication.

   .. list-table::
      :widths: 120 400
      :header-rows: 1

      * - Field
        - Value
      * - **To**
        - The email address to send the notification to.
      * - **From**
        - The email address you want to appear as the **From** field in the email message.
      * - **Subject**
        - The email subject. This is optional but recommended.
      * - **Hostname**
        - The hostname of the SMTP server.
      * - **Port**
        - The port on which the SMTP server accepts connections. This is often, but not always, port 25.
      * - **Username**
        - Optional. The username to use for authenticating with the SMTP server.
      * - **Password**
        - Optional. The password to use for authenticating with the SMTP server.

#. Click on **Save**. The new notification will be displayed in the **Notifications** list.

#. Follow the instructions in :ref:`analytics_rules_send_a_notification` to create a rule that will trigger the notification you've created.