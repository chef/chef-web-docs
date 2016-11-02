

=====================================================
Create the Organization
=====================================================

In order to begin managing your infrastructure with Enterprise Chef, you will need to create an organization. An organization is completely multi-tenant Chef infrastructure that shares nothing with other organizations on your Enterprise Chef server.

Add Organization
=====================================================
.. tag manage_webui_admin_organization_add

To add an organization:

#. Open the Chef management console.
#. Click **Administration**.
#. Click **Organizations**.
#. Click **Create**.
#. In the **Create an Organization** dialog box, enter the full and short names for the organization:

   .. image:: ../../images/step_manage_webui_admin_organization_add.png

#. Click **Create Organization**.

.. end_tag

Reset Validation Key
=====================================================
.. tag manage_webui_policy_validation_reset_key

To reset a chef-validator key:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Clients**.
#. Select a chef-validator key.
#. Click the **Details** tab.
#. Click **Reset Key**.
#. In the **Reset Key** dialog box, confirm that the key should be regenerated and click the **Reset Key** button:

   .. image:: ../../images/step_manage_webui_admin_organization_reset_key.png

#. Copy the private key:

   .. image:: ../../images/step_manage_webui_policy_client_reset_key_copy.png

   or download and save the private key locally:

   .. image:: ../../images/step_manage_webui_policy_client_reset_key_download.png

.. end_tag

Generate Knife Config File
=====================================================
.. tag manage_webui_admin_organization_generate_config

To generate a new knife configuration file:

#. Open the Chef management console.
#. Click **Administration**.
#. Click **Organizations**.
#. Click **Generate Knife Config**.
#. Specify the location to which the configuration file will be downloaded.

.. end_tag

