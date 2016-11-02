

=====================================================
Users
=====================================================

The following tasks are available for user management in Enterprise Chef:

* Creating users
* Editing a user's profile
* Changing a password
* Recovering a password
* Regenerating a private key
* Viewing a user's profile

Change Password
=====================================================
.. tag manage_webui_admin_users_change_password

To change a user's password:

#. Open the Chef management console.
#. From the drop-down list next to your username, select **My Profile**.
#. Under **Users**, click **Change Password**.
#. In the **Change Password**, enter the old password and then the new password.

   .. image:: ../../images/step_manage_webui_admin_users_change_password.png

#. When finished, click **Change Password**.

.. end_tag

Generate Config File
=====================================================
.. tag manage_webui_admin_organization_generate_config

To generate a new knife configuration file:

#. Open the Chef management console.
#. Click **Administration**.
#. Click **Organizations**.
#. Click **Generate Knife Config**.
#. Specify the location to which the configuration file will be downloaded.

.. end_tag

Get Starter Kit
=====================================================
.. tag manage_webui_admin_organization_get_starter_kit

To get the starter kit:

#. Open the Chef management console.
#. Click **Administration**.
#. Click **Organizations**.
#. Click **Starter Kit**.
#. Follow the steps on the starter kit page.

.. end_tag

Reset Client Key
=====================================================
.. tag manage_webui_policy_client_reset_key

To regenerate a client key:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Clients**.
#. Select a client key.
#. Click the **Details** tab.
#. Click **Reset Key**.
#. In the **Reset Key** dialog box, confirm that the key should be regenerated and click the **Reset Key** button:

   .. image:: ../../images/step_manage_webui_admin_organization_reset_key.png

#. Copy the private key:

   .. image:: ../../images/step_manage_webui_policy_client_reset_key_copy.png

   or download and save the private key locally:

   .. image:: ../../images/step_manage_webui_policy_client_reset_key_download.png

.. end_tag

Reset Node Key
=====================================================
.. tag manage_webui_node_reset_key

To reset the validation key for a node:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click **Edit Run List**.
#. In the **Reset Key** dialog box, confirm that the key should be regenerated and click the **Regenerate Key** button:

   .. image:: ../../images/step_manage_webui_admin_organization_reset_key.png

#. In the **Reset Key** dialog box, copy the key directly from the dialog box or click the **Download** button to download the key to your local machine:

   .. image:: ../../images/step_manage_webui_admin_organization_reset_key_regenerated.png

.. end_tag

Reset User Key
=====================================================
.. tag manage_webui_admin_users_reset_key

To reset a user's validation key:

#. Open the Chef management console.
#. From the drop-down list next to your username, select **My Profile**.
#. Under **Users**, click **Reset Key**.
#. In the **Reset Key** dialog box, confirm that the key should be regenerated and click the **Regenerate Key** button:

   .. image:: ../../images/step_manage_webui_admin_organization_reset_key.png

#. In the **Reset Key** dialog box, copy the key directly from the dialog box or click the **Download** button to download the key to your local machine:

   .. image:: ../../images/step_manage_webui_admin_organization_reset_key_regenerated.png

.. end_tag

Reset Org Key
=====================================================
.. tag manage_webui_admin_organization_reset_key

To reset the validation key:

#. Open the Chef management console.
#. Click **Administration**.
#. Click **Organizations**.
#. Click **Reset Validation Key**.
#. In the **Reset Key** dialog box, confirm that the key should be regenerated and click the **Regenerate Key** button:

   .. image:: ../../images/step_manage_webui_admin_organization_reset_key.png

#. In the **Reset Key** dialog box, copy the key directly from the dialog box or click the **Download** button to download the key to your local machine:

   .. image:: ../../images/step_manage_webui_admin_organization_reset_key_regenerated.png

.. end_tag

View User Account Details
=====================================================
.. tag manage_webui_admin_users_view_account

To view user account settings:

#. Open the Chef management console.
#. From the drop-down list next to your username, select **My Profile**.

.. end_tag

