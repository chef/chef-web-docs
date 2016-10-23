.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.0

=====================================================
Create Users
=====================================================

A new user account must be created before using the Chef server.

.. note:: If your server is in Active Directory or LDAP mode, signup is unnecessary and users can simply log in to Enterprise Chef using their credentials.

#. Visiting the Chef server management console will present users with a **Login** page, which contains a **Sign Up** link.
#. Enter the information on this page, and then click **Submit**.
#. Once the user account is created, download the private key. This key is used for API access to the Chef server. The Chef server does not keep a copy of this key, so please store it somewhere safe.

