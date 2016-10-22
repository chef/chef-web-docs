=====================================================
Users
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst 

The following tasks are available for user management in Chef server:

* Creating users
* Editing a user's profile
* Changing a password
* Recovering a password
* Regenerating a private key
* Viewing a user's profile

chef-server-ctl
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server.rst

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user.rst

org-create
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_create.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_create_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_create_options.rst

org-delete
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_delete.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_delete_syntax.rst

org-list
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_list.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_list_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_list_options.rst

org-show
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_show.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_show_syntax.rst

org-user-add
-----------------------------------------------------
.. warning:: Early RC candidates for the Chef server 12 release named this command ``org-associate``. This is the same command, with the exception of the ``--admin`` flag, which is added to the command (along with the rename) for the upcoming final release of Chef server 12.

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_add.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_add_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_add_options.rst

org-user-remove
-----------------------------------------------------
.. warning:: Early RC candidates for the Chef server 12 release named this command ``org-disociate``. This is the same command, but renamed for the upcoming final release of Chef server 12.

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_remove.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_remove_syntax.rst


user-create
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_create.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_create_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_create_options.rst

user-delete
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_delete.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_delete_syntax.rst

user-edit
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_edit.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_edit_syntax.rst

user-list
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_list.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_list_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_list_options.rst

user-show
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_show.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_show_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_show_options.rst

Chef Manage
=====================================================
This section is an alphabetical list of the various user-specific tasks that can be performed when using Chef management console.

Change Password
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_admin_users_change_password.rst

Invite a User
-----------------------------------------------------
To invite a user to an organization:

#. Open the Chef management console.
#. Click **Administration**.
#. Click **Organizations**.
#. Click **Invite User**.
#. In the **Invite User** dialog box, enter the Chef server user name for the user to be invited, and then click the **Invite** button:

   .. image:: ../../images/step_manage_webui_admin_organization_invite_user.png

   .. image:: ../../images/step_manage_webui_admin_organization_invite_user_pending.png

#. After the user accepts the invitation, they will be a member of this organization.

Cancel invite for User
-----------------------------------------------------
Canceling a pending invite for a user can currently be completed using knife:

#. As a user that is a member of the ``admins`` group, replace ``ORGNAME`` with your own ``ORGNAME`` and run:

   .. code-block:: bash

      knife raw 'association_requests' -s https://api.opscode.com/organizations/ORGNAME
   
   You may see an empty list or you may see a populated list of invites. No invites looks like this
  
   .. code-block:: bash

      [

      ]

   A single invite looks like this
   
   .. code-block:: bash

      [
        {
          "id": "f6240e73d35b1e3ce3238ab8a5131ccb",
          "username": "testuser"
        }
      ]

#. To cancel the above pending invite you would run

   .. code-block:: bash
 
      knife raw -m DELETE 'association_requests/f6240e73d35b1e3ce3238ab8a5131ccb' -s https://api.opscode.com/organizations/ORGNAME

Leave Org
-----------------------------------------------------
To leave an organization:

#. Open the Chef management console.
#. Click **Administration**.
#. Click **Organizations**.
#. Click **Leave Organization**.
#. In the **Leave Organization** dialog box, confirm that you want to leave the organization, and then click the **Leave Organization** button:

   .. image:: ../../images/step_manage_webui_admin_organization_leave.png

Remove User from Org
-----------------------------------------------------
To remove a user from an organization:

#. Open the Chef management console.
#. From the drop-down list next to your username, select **My Profile**.
#. Under **Users**, click **Leave Organization**.
#. In the **Leave Organization** dialog box, confirm that the key should be regenerated and click the **Leave Organization** button:

   .. image:: ../../images/step_manage_webui_admin_organization_leave.png

Remove Admin User from Org
-----------------------------------------------------
Removing a member of the ``admins`` group from an organization requires the user to be removed from the ``admins`` group before they can be removed from the organization:

#. Open the Chef management console.
#. Click **Administration**.
#. Click **Groups**.
#. Select the **Groups** group.
#. Select a user to be removed from the **Groups** group:

   .. image:: ../../images/step_manage_webui_admin_remove_admin_pre.png

#. Click **Remove**.

   .. image:: ../../images/step_manage_webui_admin_remove_admin_post.png

#. Click **Users**.
#. Select a user.
#. Click **Remove from Organization**.

   .. image:: ../../images/step_manage_webui_admin_remove_admin_success.png

Reset User Key
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_admin_users_reset_key.rst

View User Account Details
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_admin_users_view_account.rst
