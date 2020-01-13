=====================================================
Integrate Chef Automate with LDAP for Authentication
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/integrate_delivery_ldap.rst>`__

.. meta:: 
    :robots: noindex 

.. tag chef_automate_mark

.. image:: ../../images/a2_docs_banner.svg
   :target: https://automate.chef.io/docs

.. end_tag


.. tag EOL_a1

.. danger:: This documentation applies to a deprecated product </versions.html#deprecated-products-and-versions>`__. The new Chef Automate includes newer out-of-the-box compliance profiles, an improved compliance scanner with total cloud scanning functionality, better visualizations, role-based access control and many other features. The new Chef Automate is included as part of the Chef Automate license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

.. end_tag

.. tag delivery_integration_ldap

You can configure Chef Automate to access your own LDAP database.

.. end_tag

LDAP Attributes
=====================================================
.. tag delivery_integration_ldap_attributes

The following table describes the LDAP attributes that may be used with Chef Automate:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``ldap_attr_fullname``
     - The full user name for an LDAP user. Default value: ``nil``.
   * - ``ldap_attr_login``
     - The login user name for an LDAP user. Default value: ``sAMAccountName``.
   * - ``ldap_attr_mail``
     - The email for an LDAP user. Default value: ``mail``.
   * - ``ldap_base_dn``
     - Base dn to use when searching for users in LDAP, typically ``OU=Users`` and then the domain. Default value: ``OU=Employees,OU=Domain users,DC=examplecorp,DC=com``.
   * - ``ldap_bind_dn``
     - The user Chef Automate will use to perform LDAP searches. This is often the administrator or manager user. This user needs to have read access to all LDAP users that require authentication. The Chef Automate server must do an LDAP search before any user can log in. Many LDAP systems do not allow an anonymous bind. If anonymous bind is allowed, leave the ``bind_dn`` and ``bind_dn_password`` settings blank. If anonymous bind is not allowed, a user with ``READ`` access to the directory is required. This user must be specified as an LDAP distinguished name (``dn``). Default value: ``nil``.
   * - ``ldap_bind_dn_password``
     - The password for the user specified by ``ldap['bind_dn']``. Leave this value and ``ldap['bind_dn']`` unset if anonymous bind is sufficient. Default value: ``secret123``. We do not recommend using a backslash (``\``) in the password, but if the password needs to have a backslash, please contact support.
   * - ``ldap_encryption``
     - The type of encryption used to communicate with Chef Automate. Default value: ``start_tls``. If tls is not in use, set to ``no_tls``.
   * - ``ldap_hosts``
     - An array of hostname(s) of the LDAP server. Be sure Chef Automate is able to resolve any host names. Default value: ``[]``.
   * - ``ldap_port``
     - The default value is an appropriate value for most configurations. Default value: ``3269``.
   * - ``ldap_timeout``
     - Timeout when Chef Automate connects to LDAP. Default value: ``5000``.

.. end_tag

Configure LDAP
=====================================================
.. tag delivery_integration_ldap_configure

To configure LDAP for Chef Automate:

#. Open ``/etc/delivery/delivery.rb`` and enter the LDAP attributes you want Chef Automate to use. If you do not specify an LDAP port, the default port of ``3269`` is used.

   .. code-block:: ruby

      delivery['ldap_hosts'] = ["ldap.tld"]
      delivery['ldap_port'] = 3269
      delivery['ldap_timeout'] = 5000
      delivery['ldap_base_dn'] = "OU=Employees,OU=Domain users,DC=opscodecorp,DC=com"
      delivery['ldap_bind_dn'] = "ldapbind"
      delivery['ldap_bind_dn_password'] = "secret123"
      delivery['ldap_encryption'] = "start_tls"
      delivery['ldap_attr_login'] = 'sAMAccountName'
      delivery['ldap_attr_mail'] = 'mail'
      delivery['ldap_attr_full_name'] = 'fullName'

#. Run the following command to complete the configuration process:

   .. code-block:: bash

      $ sudo automate-ctl reconfigure

Once Chef Automate is set up, you will have a usable **LDAP** option in the Chef Automate **Users** page that allows you to find users through your LDAP database.

.. end_tag

Manage Users
=====================================================
.. tag delivery_integration_ldap_users

Integrating Chef Automate with your LDAP system allows you to automatically add more user details and authenticate users against your existing identity management system. However, even once your LDAP system has been integrated to Chef Automate, you must manually add users. If you are going to add a user in your integrated LDAP system to Chef Automate, you must have their LDAP name.

.. end_tag

Add
-----------------------------------------------------
.. tag delivery_integration_ldap_users_add

.. note:: In order to add or edit users, you must have root shell access and the **Admin** role assigned in Chef Automate.

To add or edit a user to Chef Automate:

#. Log into the Chef Automate web UI as an administrator.
#. Select **Users** from the drop-down menu on the upper right.

   The **Users** list page opens. You can use the search filter in the upper right corner to make sure that the user is not already added.
#. Click the plus sign (**+**) next to **Add a New User**.
#. In the Add New a User text area, select one of two types for the new user. The selection box is grey for the active selection.

   * **Internal** means you are manually adding the user to the Chef Automate database.

   * **LDAP** means the user is in an LDAP system that has been integrated to this Chef Automate.

   If you select **Internal**, options for **Name and Email**, first name, last name, email address, and **Security Information**, a login name and password, appear.

   If you select **LDAP**, the **Name and Email** options go away and a **Security Information** option for the user's LDAP username and SSH public key appears.
#. Enter the appropriate information for the type of user you are adding. Leave the **SSH Public Key** area blank, the user must log in and enter this information.

   Select user **Roles Within the Enterprise**.

   Click **Save and Close**, or **Cancel** to discard the operation.

   The **User** list page opens and a status message appears.

To check that the user was added properly when using LDAP, click **Edit** and verify that the user details are present.

.. end_tag

Edit
-----------------------------------------------------
.. tag delivery_integration_ldap_users_edit

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

.. end_tag

