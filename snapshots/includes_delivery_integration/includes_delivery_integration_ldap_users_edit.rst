.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. note:: In order to add or edit users, you must have root shell access and the **Admin** role assigned in Chef Automate.

To edit LDAP details for a user:

#. Log into the Chef Automate web UI as an administrator.
#. Select **Users** from the drop-down menu on the upper right.

   The **Users** list page opens. You can use the search filter in the upper right corner to make sure that the user is not already added.
#. Click the plus sign (**+**) next to **Add a New User**. 
#. In the **Add New a User** text area, select one of two types for the new user. The selection box is grey for the active selection.

   **Internal** means you are manually adding the user to the Delivery database. 

   **LDAP** means the user is in an LDAP system that has been integrated to this Chef Automate. 

   If you select **Internal**, options for **Name and Email**, first name, last name, email address, and **Security Information**, a login name and password, appear.

   If you select **LDAP**, the **Name and Email** options go away and a **Security Information** option for the user's LDAP username appears.
#. Enter the appropriate information for the type of user you are adding. Leave the **SSH Public Key**  area blank. The user must log in and enter this information.

   Select user **Roles Within the Enterprise**.

   Click **Save and Close**, or **Cancel** to discard the operation.

   The **User** list page opens and a status message appears.

To check that the user was added properly when using LDAP, click **Edit** and verify that the user details are present.
