.. THIS PAGE IS LOCATED AT THE /release/analytics/ PATH.

=====================================================
Chef Analytics
=====================================================

.. include:: ../../includes_analytics/includes_analytics_legacy.rst 

.. include:: ../../includes_analytics/includes_analytics.rst

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst

Chef Analytics Components
=====================================================
The following diagram shows the relationships between the various elements of Chef Analytics, including how information is routed from various nodes to the Chef Analytics server (through the Chef server) nodes, where reports about chef-client run outcomes may be viewed, where rules are processed, and where Chef Analytics data may be viewed.

.. image:: ../../images/chef_analytics.svg
   :width: 600px
   :align: center


.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Feature
     - Description
   * - **Controls**
     - .. include:: ../../includes_analytics/includes_analytics_controls.rst
   * - **Audit Mode**
     - .. include:: ../../includes_chef_client/includes_chef_client_audit_mode.rst
   * - **Chef Actions**
     - .. include:: ../../includes_actions/includes_actions.rst
   * - **Reporting**
     - .. include:: ../../includes_reporting/includes_reporting.rst
   * - **Rules**
     - .. include:: ../../includes_analytics_rules/includes_analytics_rules.rst

The following sections discuss these elements (and their various components) in more detail.

Integrations
=====================================================
Chef Analytics can integrate with HipChat, Slack and Splunk as well as send notifications via email and trigger webhooks.

HipChat
-----------------------------------------------------
HipChat integration allows Chef Analytics to send real-time event notifications to a HipChat room.

.. note:: You must have room owner or administrator privileges for the HipChat room you wish to send notifications to.

.. note:: Chef Analytics must be able to make HTTPS (port 443) requests to the HipChat API in order to send notifications. Ensure that your network is configured correctly before proceeding.

To begin, get your room ID and room notification token from HipChat:

#. Log in to the HipChat web interface, e.g. \http://mycompany.hipchat.com/.

#. Click on the **Rooms** tab, then click on **My Rooms** and then click on the name of your room.

   .. image:: ../../images/analytics_hipchat_rooms.png

#. Copy the **API ID** from the Room Details table—this is the room ID.

   .. image:: ../../images/analytics_hipchat_room_api_id.png

#. Click on **Tokens** in the left sidebar.

#. In the **Create new token** dialog enter a label in the **Label** field, e.g. "Chef Analytics." Ensure that "Send Notification" is selected and then click on **Create**.

   .. image:: ../../images/analytics_hipchat_create_new_token.png

   The new room notification token will be displayed at the top of the page; copy it as well.

     .. image:: ../../images/analytics_hipchat_room_notification_token.png

Next, create a notification in Chef Analytics:

#. Log in to Chef Analytics and click on the **Notifications** tab

#. Click on the **+** button, then click on **Hipchat**

   .. image:: ../../images/analytics_hipchat_new_notification.png

   The HipChat Notification form will appear.

#. Enter a name for your notification by clicking on the field to the right
   of **Hipchat Notification:**.

   .. image:: ../../images/analytics_hipchat_create_form.png

#. Fill out the following fields:

   .. list-table::
      :widths: 120 400
      :header-rows: 1

      * - Field
        - Value
      * - **HipChat Host**
        - Most users should use ``https://api.hipchat.com``. However, if you
          use a self-hosted HipChat server, enter its API URL. If you don't
          know it, ask your system administrator.

          .. note:: The HipChat Host URL **must not** end with ``/v1`` or ``/v2``. Chef Analytics will automatically append the correct path to the URL according to the **HipChat API version** chosen (see below). If the default value when creating a new notification ends in ``/v1`` or ``/v2``, remove that part before saving.
      * - **Room to send message to**
        - Enter the room ID ("API ID") you copied in (3) above.
      * - **From**
        - Optional. Enter an additional name to appear in HipChat with notifications.
      * - **Token to use for authentication**
        - Enter the room notification token you copied in (5) above.
      * - **HipChat API version**
        - Most users should choose "2".
      * - **Color**
        - Choose a color for the notification. Defaults to yellow.
      * - **Notify the room**
        - Optional. Choose "yes" if you want HipChat to alert room participants when
          the room recieves this notification. Otherwise choose "no."

#. Click on **Save**. The new notification will be displayed in the **Notifications** list.

#. Follow the instructions in :ref:`analytics_rules_send_a_notification` to create a rule that will trigger the notification you've created.

Slack
-----------------------------------------------------
.. include:: ../../includes_analytics/includes_analytics_webhook_example_slack.rst

Chef App for Splunk
-----------------------------------------------------
.. include:: ../../includes_analytics/includes_analytics_splunk.rst

Email
-----------------------------------------------------
Chef Analytics can be configured to send event notifications by email.

.. note:: Chef Analytics must be able to connect to an SMTP server on the configured port. Ensure that your network is configured correctly before proceeding.

#. To begin, log in to Chef Analytics and click on the **Notifications** tab.

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

Webhooks
-----------------------------------------------------
For an example of creating a notification that integrates with a remote service via webhooks, see the Slack integration section (above).

Controls
=====================================================
.. include:: ../../includes_analytics/includes_analytics_controls.rst

Recipe DSL Methods
-----------------------------------------------------
The following methods are built into the Recipe DSL and may be used to configure tests that are run while the chef-client is run in audit-mode:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Method
     - Description
   * - ``control``
     - .. include:: ../../includes_chef_client/includes_chef_client_audit_mode.rst
   * - ``control_group``
     - .. include:: ../../includes_chef_client/includes_chef_client_audit_mode.rst

Audit Mode
=====================================================
.. include:: ../../includes_chef_client/includes_chef_client_audit_mode.rst

The Audit Run
-----------------------------------------------------
.. include:: ../../includes_chef_client/includes_chef_client_audit_mode_run.rst

Reporting
=====================================================
.. include:: ../../includes_reporting/includes_reporting.rst

The Reporting Run
-----------------------------------------------------
.. include:: ../../includes_reporting/includes_reporting_run.rst

Rules
=====================================================
.. include:: ../../includes_analytics_rules/includes_analytics_rules.rst

.. note:: For more information about Chef Analytics rules, see https://docs.chef.io/analytics_rules.html.

Chef Analytics Webui
=====================================================
.. include:: ../../includes_actions/includes_actions.rst

Architecture
-----------------------------------------------------
.. include:: ../../includes_actions/includes_actions_architecture.rst

Data Tracking
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_actions/includes_actions_tracked_data.rst

User Interface
-----------------------------------------------------
.. include:: ../../includes_analytics/includes_analytics_ui.rst

Reference Topics
=====================================================
See the following links for information about installing, monitoring, using command-line tools, and configuration file settings:

* :doc:`Install Chef Analytics </install_analytics>`
* :doc:`Monitor Chef Analytics </analytics_monitor>`
* :doc:`opscode-analytics-ctl </ctl_analytics>`
* :doc:`opscode-analytics.rb </config_rb_analytics>`
