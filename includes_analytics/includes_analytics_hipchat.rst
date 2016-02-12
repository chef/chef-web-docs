.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|hipchat| integration allows |chef analytics| to send real-time event notifications to a |hipchat| room.

.. note:: You must have room owner or administrator privileges for the |hipchat| room you wish to send notifications to.

.. note:: |chef analytics| must be able to make HTTPS (port 443) requests to the |hipchat| API in order to send notifications. Ensure that your network is configured correctly before proceeding.

To begin, get your room ID and room notification token from |hipchat|:

#. Log in to the |hipchat| web interface, e.g. \http://mycompany.hipchat.com/.

#. Click on the **Rooms** tab, then click on **My Rooms** and then click on the name of your room.

   .. image:: ../../images/analytics_hipchat_rooms.png

#. Copy the **API ID** from the Room Details table—this is the room ID.

   .. image:: ../../images/analytics_hipchat_room_api_id.png

#. Click on **Tokens** in the left sidebar.

#. In the **Create new token** dialog enter a label in the **Label** field, e.g. "|chef analytics|." Ensure that "Send Notification" is selected and then click on **Create**.

   .. image:: ../../images/analytics_hipchat_create_new_token.png

   The new room notification token will be displayed at the top of the page; copy it as well.

     .. image:: ../../images/analytics_hipchat_room_notification_token.png

Next, create a notification in |chef analytics|:

#. Log in to |chef analytics| and click on the **Notifications** tab

#. Click on the **+** button, then click on **Hipchat**

   .. image:: ../../images/analytics_hipchat_new_notification.png

   The |hipchat notification| form will appear.

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
          use a self-hosted |hipchat| server, enter its API URL. If you don't
          know it, ask your system administrator.

          .. note:: The HipChat Host URL **must not** end with ``/v1`` or ``/v2``. |chef analytics| will automatically append the correct path to the URL according to the **HipChat API version** chosen (see below). If the default value when creating a new notification ends in ``/v1`` or ``/v2``, remove that part before saving.
      * - **Room to send message to**
        - Enter the room ID ("API ID") you copied in (3) above.
      * - **From**
        - Optional. Enter an additional name to appear in |hipchat| with notifications.
      * - **Token to use for authentication**
        - Enter the room notification token you copied in (5) above.
      * - **HipChat API version**
        - Most users should choose "2".
      * - **Color**
        - Choose a color for the notification. Defaults to yellow.
      * - **Notify the room**
        - Optional. Choose "yes" if you want |hipchat| to alert room participants when
          the room recieves this notification. Otherwise choose "no."

#. Click on **Save**. The new notification will be displayed in the **Notifications** list.

#. Follow the instructions in :ref:`analytics_rules_send_a_notification` to create a rule that will trigger the notification you've created.