=====================================================
Manage Users and Roles
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/delivery_users_and_roles.rst>`__

.. meta:: 
    :robots: noindex 

.. tag chef_automate_mark

.. image:: ../../images/a2_docs_banner.svg
   :target: https://automate.chef.io/docs

.. end_tag


.. tag EOL_a1

.. danger:: This documentation applies to a deprecated product </versions.html#deprecated-products-and-versions>`__. The new Chef Automate includes newer out-of-the-box compliance profiles, an improved compliance scanner with total cloud scanning functionality, better visualizations, role-based access control and many other features. The new Chef Automate is included as part of the Chef Automate license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

.. end_tag

This topic describes the roles and permissions that may be assigned to users of Chef Automate, how to integrate an LDAP system with Chef Automate, how to add and edit users, and how to add user SSH keys.

Roles and Permissions
=====================================================
Chef Automate has a standard users and roles permissions scheme. Roles are sets of permissions defined by Chef Automate. Users can be assigned multiple roles.

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Role
     - Permissions
   * - **Admin**
     - All of the permissions plus all administrative permissions, including user management. Can create and delete users and restore passwords. Also, can create, delete, or modify organizations, projects, and pipelines. Can modify, delete, or add recipes in a phase (at the source code level); and can read and write comments.
   * - **Committer**
     - Can commit a change to Chef Automate. Also, can modify, delete, or add recipes in a phase (at the source code level); and can read and write comments.
   * - **Observer**
     - Can observe the actions and results of the pipeline as the change progresses through the stages. Cannot take any action.
   * - **Reviewer**
     - Can approve the successful completion of the **Verify** stage. Once approved, the change automatically moves to the **Build** stage. Also, can read and write comments.
   * - **Shipper**
     - Can ship a change from the **Acceptance** stage into the shared pipeline stages, **Union** **Rehearsal** and **Delivered**.

Integrate LDAP
=====================================================
.. tag delivery_integration_ldap

You can configure Chef Automate to access your own LDAP database.

.. end_tag

LDAP Attributes
-----------------------------------------------------
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
-----------------------------------------------------
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
-----------------------------------------------------
.. tag delivery_integration_ldap_users

Integrating Chef Automate with your LDAP system allows you to automatically add more user details and authenticate users against your existing identity management system. However, even once your LDAP system has been integrated to Chef Automate, you must manually add users. If you are going to add a user in your integrated LDAP system to Chef Automate, you must have their LDAP name.

.. end_tag

Add
+++++++++++++++++++++++++++++++++++++++++++++++++++++
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
+++++++++++++++++++++++++++++++++++++++++++++++++++++
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

Onboard Users
=====================================================
Onboarding users to a project is different depending on whether you have integrated with GitHub or not.

Chef Automate with GitHub
-----------------------------------------------------
Once a project is created, you will want to add users to that project so that they can submit changes and collaborate via the Chef Automate shared workflow using GitHub.

You may integrate Chef Automate and GitHub Enterprise or `Github.com <https://github.com/>`__. If you do this, you will be able to use GitHub as a **Source Code Provider** when creating a project.

.. note:: Before you can follow this procedure, you must have integrated Chef Automate and GitHub Enterprise or `Github.com <https://github.com/>`__. This is the same procedure whether you have Amazon Web Services (AWS) provisioning or SSH provisioning.

Add Users
+++++++++++++++++++++++++++++++++++++++++++++++++++++
You must associate a GitHub user with a Chef Automate user in order to successfully create changes from GitHub pull requests.

To onboard a user for an integrated GitHub Enterprise project or one that is hosted at `Github.com <https://github.com/>`__:

#. Have the user that you want to add clone the repo for the project you want them to join. Ensure that they have write permissions to the repo if you want to allow them to submit pull requests.
#. Add or edit any users who are managed by the LDAP integration.
#. From a local checkout of a Chef Automate project, run the appropriate Chef Automate command that associates a GitHub user with a Chef Automate user.

   .. note:: The Delivery CLI commands are for a user to link their own account to GitHub, or others if the user has the **Admin** role; ``api`` is an argument to the Delivery CLI command. The ``automate-ctl`` command can only be run by an administrator from the Chef Automate server and can affect any user.

   For GitHub Enterprise:

   .. code-block:: bash

      $ delivery api put users/$AUTOMATE_USERNAME/set-oauth-alias --data='{"app_name":"github-enterprise","alias":"$GITHUB_USERNAME"}'

   For GitHub:

   .. code-block:: bash

      $ delivery api put users/$AUTOMATE_USERNAME/set-oauth-alias --data='{"app_name":"github","alias":"$GITHUB_USERNAME"}'

   *Or*, as an administrator, run the command line tool ``automate-ctl``. The command uses the enterprise name you set when configuring Chef Automate. The username can be an LDAP username (if LDAP integration has been completed), or an internal username:

   For GitHub Enterprise:

   .. code-block:: bash

      $ automate-ctl link-github-enterprise-user $AUTOMATE_ENTERPRISE_NAME $AUTOMATE_USERNAME $GITHUB_USERNAME

   For GitHub:

   .. code-block:: bash

      $ automate-ctl link-github-user $AUTOMATE_ENTERPRISE_NAME $AUTOMATE_USERNAME $GITHUB_USERNAME

The associated user can now checkout the repository, make changes on a feature branch and submit the changes for review.

Note the following constraints:

* You may not link two GitHub accounts to a single Chef Automate user.
* Two users may not share a GitHub account

Submit Changes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
For an integrated GitHub Enterprise project or a project that is hosted on `Github.com <https://github.com/>`__, users of Chef Automate should submit changes as follows:

#. The standard GitHub process should be followed:

   * Clone the desired repository
   * Make and test changes locally
   * Submit the changes and initiate the Chef Automate review process by creating a pull request with the ``delivery review`` command

   The GitHub webui will display a **Delivery Status** box showing what part of the pipeline the pull request is at. When the pull request has passed the **Verify** stage, GitHub will message you in the GitHub webui that approval must be manually entered for the pipeline to proceed.

#. When the "Approval Required" message appears, enter ``@delivery approve`` in the comment box.

   The pull request moves to the next stage of the Chef Automate pipeline, **Build** and **Acceptance**.

#. When the pull request has passed the **Acceptance** stage, GitHub will add another message indicating that that the ``deliver`` command must be issued for the pipeline to proceed. When this message appears, enter ``@delivery deliver`` in the comment box.

   The pull request moves to the final three stages, **Union**, **Rehearsal**, and **Delivered**. Other changes in the pipeline that would conflict with a change in the **Union** stage, are blocked from proceeding to the **Acceptance** stage.

   When the final **Delivered** stage is passed, GitHub updates the **Delivery Status** at the top of the GitHub webui page.

Chef Automate with Internal git
-----------------------------------------------------
Once a project is created, you will want to add users to that project so that they can submit changes and collaborate via the Chef Automate shared workflow. These procedures apply to Chef Automate deployments that are using the internal Chef Automate git capabilities and are not integrated to GitHub Enterprise or `Github.com <https://github.com/>`__.

Add Users
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To onboard a user that is not using GitHub Enterprise or a project hosted at `Github.com <https://github.com/>`__, but only the default git that comes with Chef Automate:

#. Add or edit any users who are managed by the LDAP integration.
#. Have the user log into the Chef Automate web UI and add their SSH public key to their profile.

The associated user can now create a feature branch and submit changes to Chef Automate for review.

Submit Changes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The change submission process is the familiar git process:

#. You must be onboarded to Chef Automate, a task likely to be done by your sysadmin. Once your GitHub username is linked to your Chef Automate username and you have properly set up a workstation.
#. Clone the GitHub repo to which changes are submitted. Be sure you have the right permissions.
#. Workflow for making changes:

   #. Create feature branch: ``git checkout -b <feature_branch_name>``.
   #. Make changes.
   #. Build and test the changes locally.
   #. Check status: ``git status``.
   #. Add changes: ``git add .`` or ``git add <changed file>``.
   #. Commit changes: ``git commit -m <message>``.
   #. Submit changes to delivery: ``delivery review``. The Chef Automate web UI will open to show your change in the pipeline. Note, you may need to be on a VPN to access Chef Automate.
   #. When the change has passed **Verify**, approve change, or get someone to, by clicking **Approve** in Chef Automate web UI. Doing this marks you as the "Signed-off-by" user of the change.
   #. After change is approved, sync your local branch to master: ``git checkout master`` and then ``git pull delivery master``.
   #. Press the **Deliver** button in the Chef Automate web UI when it is active. Note that your change may be superseded by another change. That is, if another change in the pipeline is approved (merged to master) and then your change is approved, when **Deliver** is pressed, both changes are moved to the final three stages. This goes for all approved changes in the pipeline. Also note that changes that would conflict with approved changes will not be moved past **Acceptance**.

Add User SSH Keys
=====================================================
First install the Delivery CLI, and then generate the user's SSH keys.

Install the CLI
-----------------------------------------------------
.. tag delivery_cli_install

The Delivery CLI is required for the workstation and for many Chef Automate functions. It is included in ChefDK and can be obtained by `installing the latest version </install_dk.html>`__.

.. note:: You must delete your old Delivery CLI if you installed it prior to it being included in ChefDK.

.. end_tag

Configure the CLI
-----------------------------------------------------
.. tag delivery_cli_configure

Before you use the Delivery CLI from a workstation, you need to provide it with details such as the URL of the Chef Automate server, and the names of the relevant enterprise, organization, and user. The ``delivery setup`` subcommand creates a configuration file named ``.delivery/cli.toml`` with the required information.

The placement of the ``.delivery`` directory in your file hierarchy is significant. Like git, Delivery CLI commands search the current directory and parent directories to locate server settings. Because server settings are unique to an organization, we recommend that you create a directory for each organization you belong to and run the ``delivery setup`` command from that directory.

.. code-block:: bash

   $ delivery setup --server=DELIVERY_SERVER_IP_ADDR --ent=ENTERPRISE --org=ORGANIZATION --user=USERNAME

The following settings may be added to the ``.delivery/cli.toml`` file:

``auto_bump``
   Bumps the cookbook metadata version number automatically when ``delivery review`` is run. Default value: ``false``.

.. end_tag

Add SSH Keys
-----------------------------------------------------
To add SSH keys to Chef Automate, do the following:

#. Check for an SSH key:

   .. code-block:: bash

      $ cat .ssh/id_rsa.pub

   if it returns:

   .. code-block:: none

      No such file or directory

#. Create an SSH key (without a passphrase):

   .. code-block:: bash

      $ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

   The output is similar to:

   .. code-block:: none

      Generating public/private rsa key pair.
      Enter file in which to save the key (/Users/username/.ssh/id_rsa):
      Enter passphrase (empty for no passphrase):
      Enter same passphrase again:
      Your identification has been saved in /Users/path/to/.ssh/id_rsa.
      Your public key has been saved in /Users/path/to/.ssh/id_rsa.pub.
      The key fingerprint is:
      ac:8a:57:90:58:c1:cd:34:32:18:9d:f3:79:60:f3:41 your_email@chef.io
      The key's randomart image is:
      +--[ RSA 4096]----+
      |  .==*o.E        |
      |  . *o*..        |
      |   o + = .       |
      |  . o o.o        |
      |     . ..S       |
      |      ..         |
      |     ..          |
      |   .*o*.         |
      |  ...            |
      +-----------------+

#. Run the following:

   .. code-block:: bash

      $ cat .ssh/id_rsa.pub

   The output is similar to:

   .. code-block:: none

      ssh-rsa
      AAAAB3NzaC1yc2EAAAADAQABAAACAQDa8BR/9bj5lVUfQP9Rsqon5qJMkiVm+JAtGi
      wnhxqgyRhkYLIzm6+gcifDgMOMuwZA88Ib5WNRhxjlmTseapower4rH/jAAczdp1h1
      7xLEEbUfQfkcqiy/Drp3k12345678ad234fgvdsasdfasdfR9ddNIeNvQ7OIpOCfLE
      PCyFz3aRRuhpM/5cySFT7bl1O44bNgfiuqRzcXFscZb03WPlhaPwCvL2uxaRzdrAGQ
      mE5jzCo6nORvKoGdVDa2++def33f3xPZCo3oJ08Q9XJ2CnfJlmyNe1hwI2NOQ3yRbc
      nfSMona7ccSyHRWGs5bS//u6P0NK5AqH5jK8pg3XwtHZqLwUVy1wX0WnnJWg9IWXf3
      2g3P4O4NJGVUeX33Czv32GK8YphuEweqFu/Ej7kQp1ppIxkEtrpBfMi3na0QqZlk6w
      wghZLa++DUfWOhGsuuBgnsocAR5rLGy+gkypdie1Ydoe8qjLVZR/jKybQfQjuZOS30
      fZnwJhl2ZaeraPfkEXlVhK02/8PIALGfeXdt9KvQN0p5c6lRoDxqBqslM+1KbKKcGd
      lSGEsAIP9OOWBECRxlOwqlqGHtrgWKOr376dntMIy2+fFD/74tJMjRwbRzm8IGWmj6
      OcF6EvTYYO4RmISD8G+6dm1m4MlxLS53aZQWgYWvRdfNB1DA
      Zo3h9Q== your_email@chef.io

#. Copy the SSH key and add it to Chef Automate.

   Log into the Chef Automate web UI as an administrator.

   Select **Users** from the drop-down menu on the upper right.

   On the **Users** list page, select the user name; use the search filter in the upper right if needed.

   Under **Security Information**, paste the SSH key.

   Click **Save & Close**.

#. Setup Chef Automate for that user. Run the following:

   .. code-block:: bash

      $ delivery setup --server SERVER_DNS --user USERNAME --ent ENTERPRISE --org ORGANIZATION

   The output is similar to:

   .. code-block:: none

      Chef Delivery
      Loading configuration from /Users/USERNAME
      Writing configuration to /Users/USERNAME/.delivery/cli.toml
      New configuration
      -----------------
      api_protocol = "https"
      enterprise = "ENTERPRISE"
      git_port = "8989"
      organization = "ORGANIZATION"
      pipeline = "master"
      server = "SERVER_DNS"
      user = "USERNAME"

#. Clone a repo from Chef Automate:

   .. code-block:: bash

      $  delivery clone PROJECT_REPO

   The output is similar to:

   .. code-block:: none

      Chef Delivery
      Loading configuration from /Users/USERNAME/Desktop
      Cloning ssh://USERNAME@chef@SERVER_DNS:8989/ENTERPRISE/ORGANIZATION/PROJECT to PROJECT
      The authenticity of host '[SERVER_DNS]:8989 ([10.100.10.50]:8989)' can't be established.
      RSA key fingerprint is 42:8d:92:31:9e:55:b0:06:28:b7:35:a9:4a:87:47:9d.
      Are you sure you want to continue connecting (yes/no)? yes
      adding remote delivery: ssh://USERNAME@ENTERPRISE@SERVER_DNS:8989/ENTERPRISE/ORGANIZATION/PROJECT

The user can now create a local branch, make and submit changes to Chef Automate.
