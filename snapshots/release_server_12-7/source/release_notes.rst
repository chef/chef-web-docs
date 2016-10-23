=====================================================
Release Notes: Chef Server 12.7
=====================================================

.. include:: ../../includes_chef/includes_chef_index.rst

What's New
=====================================================
The following items are new for Chef server 12.7:

* **Support for service credential rotation through Veil** Veil is a library for securely creating, storing, and rotating Chef server secrets. It is also required when using the new ``chef-server-ctl require-credential-rotation`` command.
* **Filtering by external authentication ID in Chef server API** Users can now be filtered by ``external_authentication_uid``, which is needed to support SAML authentication in Chef Manage.
* **Updated to OpenSSL 1.0.1t** Version 1.0.1t contains several security fixes.

Service credential rotation support
=====================================================
`Veil <https://github.com/chef/chef-server/blob/3ff412b5a2e6ad54cfa79bca6865e1bbca28fe5e/omnibus/files/veil/README.md>`_ is a new library to manage Chef server secrets. It allows any Chef server with a given set of secrets to create new service credentials and rotate them without requiring the secrets files to be copied between each Chef server in a cluster.

Five new commands have been created to support credential rotation:

* `require-credential-rotation <https://docs.chef.io/ctl_chef_server.html#require-credential-rotation>`_
* `rotate-all-credentials <https://docs.chef.io/ctl_chef_server.html#rotate-all-credentials>`_
* `rotate-credentials <https://docs.chef.io/ctl_chef_server.html#rotate-credentials>`_
* `rotate-shared-secrets <https://docs.chef.io/ctl_chef_server.html#rotate-shared-secrets>`_
* `show-service-credentials <https://docs.chef.io/ctl_chef_server.html#show-service-credentials>`_

Your secrets file is located at ``/etc/opscode/private-chef-secrets.json``, so whenever you rotate your service credentials, or update your shared secrets, this file will contain the changes. 

Supporting SAML-authentication in Chef Manage
=====================================================
To support SAML-authentication in Chef Manage, you can now filter users using ``external_authentication_uid`` in a GET request against the Chef server API. For example, to retrieve users where the ``external_authentication_uid`` is ``jane@doe.com``, do the following:

.. code-block:: none

   GET /users?external_authentication_uid=jane%40doe.com

What's Fixed
=====================================================
For the list of issues that were addressed for this release, please see the changelog on GitHub: https://github.com/chef/chef-server/blob/master/CHANGELOG.md
