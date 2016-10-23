.. THIS PAGE IS IDENTICAL TO docs.chef.io/delivery_users_and_roles.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/delivery/ PATH.

=====================================================
Manage Users and Roles
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst 

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
.. include:: ../../includes_delivery_integration/includes_delivery_integration_ldap.rst

LDAP Attributes
-----------------------------------------------------
.. include:: ../../includes_delivery_integration/includes_delivery_integration_ldap_attributes.rst

Configure LDAP
-----------------------------------------------------
.. include:: ../../includes_delivery_integration/includes_delivery_integration_ldap_configure.rst

Manage Users
-----------------------------------------------------
.. include:: ../../includes_delivery_integration/includes_delivery_integration_ldap_users.rst

Add
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery_integration/includes_delivery_integration_ldap_users_add.rst

Edit
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery_integration/includes_delivery_integration_ldap_users_edit.rst

Onboard Users
=====================================================
Onboarding users to a project is different depending on whether you have integrated with GitHub or not.

Chef Automate with GitHub
-----------------------------------------------------
Once a project is created, you will want to add users to that project so that they can submit changes and collaborate via the Chef Automate shared workflow using GitHub.

You may integrate Chef Automate and GitHub Enterprise or https://github.com/. If you do this, you will be able to use GitHub as a **Source Code Provider** when creating a project. 

.. note:: Before you can follow this procedure, you must have integrated Chef Automate and GitHub Enterprise or https://github.com/. This is the same procedure whether you have Amazon Web Services (AWS) provisioning or SSH provisioning.

Add Users
+++++++++++++++++++++++++++++++++++++++++++++++++++++
You must associate a GitHub user with a Chef Automate user in order to successfully create changes from GitHub pull requests.

To onboard a user for an integrated GitHub Enterprise project or one that is hosted at https://github.com/:

#. Have the user that you want to add clone the repo for the project you want them to join. Ensure that they have write permissions to the repo if you want to allow them to submit pull requests.
#. Add or edit any users who are managed by the LDAP integration.
#. From a local checkout of a Chef Automate project, run the appropriate Chef Automate command that associates a GitHub user with a Chef Automate user.

   .. note:: The Delivery CLI commands are for a user to link their own account to GitHub, or others if the user has the **Admin** role; ``api`` is an argument to the Delivery CLI command. The ``delivery-ctl`` command can only be run by an administrator from the Chef Automate server and can affect any user.

   For GitHub Enterprise:

   .. code-block:: bash

      $ delivery api put users/$AUTOMATE_USERNAME/set-oauth-alias --data='{"app_name":"github-enterprise","alias":"$GITHUB_USERNAME"}'

   For GitHub:

   .. code-block:: bash

      $ delivery api put users/$AUTOMATE_USERNAME/set-oauth-alias --data='{"app_name":"github","alias":"$GITHUB_USERNAME"}'

   *Or*, as an administrator, run the command line tool ``delivery-ctl``. The command uses the enterprise name you set when configuring Chef Automate. The username can be an LDAP username (if LDAP integration has been completed), or an internal username:

    For GitHub Enterprise:

    .. code-block:: bash

       $ delivery-ctl link-github-enterprise-user $AUTOMATE_ENTERPRISE_NAME $AUTOMATE_USERNAME $GITHUB_USERNAME

    For GitHub:

   .. code-block:: bash

      $ delivery-ctl link-github-user $AUTOMATE_ENTERPRISE_NAME $AUTOMATE_USERNAME $GITHUB_USERNAME

The associated user can now checkout the repository, make changes on a feature branch and submit the changes for review.

Note the following constraints:

* You may not link two GitHub accounts to a single Chef Automate user.
* Two users may not share a GitHub account

Submit Changes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
For an integrated GitHub Enterprise project or a project that is hosted at https://github.com/, users of Chef Automate should submit changes as follows:

#. The standard GitHub process should be followed: clone the desired repo, make and test changes locally, submit the change (create a pull request) which initiates the Chef Automate review process.

   The GitHub webui will display a **Delivery Status** box showing what part of the pipeline the pull request is at. When the pull request has passed the **Verify** stage, GitHub will message you in the GitHub webui that approval must be manually entered for the pipeline to proceed.

#. When the "Approval Required" message appears, enter ``@delivery approve`` in the comment box.

   The pull request moves to the next stage of the Chef Automate pipeline, **Build** and **Acceptance**.

#. When the pull request has passed the **Acceptance** stage, GitHub will add another message indicating that that the ``deliver`` command must be issued for the pipeline to proceed. When this message appears, enter ``@delivery deliver`` in the comment box.

   The pull request moves to the final three stages, **Union**, **Rehearsal**, and **Delivered**. Other changes in the pipeline that would conflict with a change in the **Union** stage, are blocked from proceeding to the **Acceptance** stage.

   When the final **Delivered** stage is passed, GitHub updates the **Delivery Status** at the top of the GitHub webui page.

Chef Automate with Internal git
-----------------------------------------------------
Once a project is created, you will want to add users to that project so that they can submit changes and collaborate via the Chef Automate shared workflow. These procedures apply to Chef Automate deployments that are using the internal Chef Automate git capabilities and are not integrated to GitHub Enterprise or https://github.com. 

Add Users
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To onboard a user that is not using GitHub Enterprise or a project hosted at https://github.com/, but only the default git that comes with Chef Automate:

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
.. include:: ../../includes_delivery/includes_delivery_cli_install.rst

Configure the CLI
-----------------------------------------------------
.. include:: ../../includes_delivery/includes_delivery_cli_configure.rst

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
  
