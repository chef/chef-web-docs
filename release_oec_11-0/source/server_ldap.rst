.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.0

=====================================================
LDAP and Active Directory
=====================================================

|chef server oec| supports |windows ad| and |ldap| authentication. This allows users to log in to |chef server oec| by using their corporate credentials instead of a separate password.

Configure LDAP
=====================================================
.. include:: ../../includes_config/includes_config_rb_chef_server_enterprise_settings_ldap.rst

.. note:: If the |enterprise rb| file does not exist, create a file called ``private-chef.rb`` and put it in the ``/etc/opscode/`` directory.

When the settings for |ldap| or |windows ad| are changed in the |enterprise rb| file, run the following command after saving those changes:

.. code-block:: bash

   $ private-chef-ctl reconfigure

At this point, all users will be able to use their |windows ad| or |ldap| username and password to log in to |chef server oec|. The first time they log in, they can either create a new account linked to their |windows ad| credentials or link an existing |chef server oec| account to their |windows ad| credentials.

Login when LDAP and/or AD is Enabled
=====================================================
|chef server oec| supports |windows ad| and |ldap| authentication, which enables users to log in using corporate credentials instead of also having a unique password in |chef server oec|. To set up |windows ad| and/or |ldap|, follow the instructions in the |windows ad| / |ldap| installation section of this guide.

When |windows ad| or |ldap| is enabled, the login page will authenticate users using those credentials.

First-time Login
=====================================================
For users who have not previously logged into |chef server oec|, they will log in using their |windows ad| or |ldap| credentials. After the initial login, each user will be presented with a screen asking them if they would like to create a new user with an account name derived from their login name, or if they would like to link their |windows ad| or |ldap| account to an existing |chef server oec| user account.

Once the user creates their new account they will be taken to the organization page, just as any other user would upon logging in. The user will not be shown the link account page again after their credentials are linked to a |chef server oec| account.

Access the WebUI
=====================================================
If a user already has a |chef server oec| account prior to |windows ad| or |ldap| being set up, then that user should initially login with their |windows ad| or |ldap| credentials. They will then be taken to the link account page and have the option of indicating that they already have a |chef server oec| account.

The user will put in their |chef server oec| account username and password. This will cause the account to be linked to the user's |windows ad| or |ldap| credentials, so that when the user logs they will already be using their existing |chef server oec| account. The user will not be shown the link account page again.

Access when LDAP and/or AD is Down
=====================================================
In the event that the |windows ad| or |ldap| server goes down or becomes unreachable it is still possible for a user to log into |chef server oec| as long as they have a system recovery password set on their |chef server oec| account.

To set or remove a system recovery password for a user, see the instructions in the |private chef ctl| password section of this guide.

Once a user has a system recovery password, they can log into the system by clicking the System Recovery link found on the right hand side of the login page.

Once on the System Recovery page, the user will be asked to enter their username and system recovery password.

Once the user successfully logs in, they will gain access to the system and see the same screens as if |windows ad| or |ldap| were functioning.

If a user does not have a system recovery password enabled for their account (even if they have a system recovery password set) they will be redirected to the login page and a message will be shown stating that they do not have System Recovery enabled and to contact the system administrator.