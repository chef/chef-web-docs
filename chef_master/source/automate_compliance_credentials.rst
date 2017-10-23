==============================
Credentials
==============================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/automate_compliance_credentials.html>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

The Chef Automate Compliance Credentials tab allows you to add, edit, and delete ``SSH``, ``WinRm``, and ``Sudo`` credentials for accessing remote nodes.

.. tag beta_note

This feature is in ``beta`` release. To access this feature, place your cursor anywhere on an Automate page, type ``beta`` and enable the feature.

.. end_tag

Adding SSH, WinRM, and Sudo credentials is the essential first step for using the Chef Automate Compliance Scanner. After adding credentials, you’ll be able to add nodes and create ad-hoc scan jobs.

Depending on how you’ve set up your nodes, you may need to set up more than one key that uses the same SSH Private Key with different usernames. For example, AWS EC2 Amazon Linux nodes require the username ``ec2-user``, while AWS EC2 Ubuntu nodes require the username ``ubuntu`` or ``root``. The **Credentials** tab enable saving two different sets of credentials, both using the same SSH Private Key and different user names.  However, credentials with different content may also reuse identical key names; it may be advisable to reduce confusion by follow a naming pattern specifying the key name and platform to distinguish between similar credentials.

.. Warning:: A credential name may be reused, even when it contains different usernames or keys.

Add a Credential
------------------------------------------

Add a SSH Credential
++++++++++++++++++++++++++++++++++++++++++
.. image:: ../../images/automate_credentials_ssh.png
   :height: 400px

**SSH** requires a credential name, a user name and either a SSH password **or** a SSH Private key, but not both.

Add a WinRM Credential
++++++++++++++++++++++++++++++++++++++++++

.. image:: ../../images/automate_credentials_WinRM.png
   :height: 200px

**WinRM** requires a credential name, a user name, and a WinRM password.

Add a Sudo Credential
++++++++++++++++++++++++++++++++++++++++++

.. image:: ../../images/automate_credentials_sudo.png
   :height: 200px

**Sudo** requires a credential name, a user name, and a password **or** sudo options, but not both.

Credentials will be visible in the **Manage Credentials** view after clicking the **Save Credential** button. If you are not redirected to the credentials list, then review the credential you are attempting to add.

Manage Credentials
------------------------------------------

.. image:: ../../images/automate_credentials_manage.png

Edit and delete credentials using the icons on the right side of the credential rows.