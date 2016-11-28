=====================================================
Release Notes: Chef Server 12.7
=====================================================

.. tag chef_index

Chef is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure. Each organization is comprised of one (or more) workstations, a single server, and every node that will be configured and maintained by the chef-client. Cookbooks (and recipes) are used to tell the chef-client how each node in your organization should be configured. The chef-client (which is installed on every node) does the actual configuration.

.. end_tag

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

* :ref:`require-credential-rotation <ctl_chef_server-require-credential-rotation>`
* :ref:`rotate-all-credentials <ctl_chef_server-rotate-all-credentials>`
* :ref:`rotate-credentials <ctl_chef_server-rotate-credentials>`
* :ref:`rotate-shared-secrets <ctl_chef_server-rotate-shared-secrets>`
* :ref:`show-service-credentials <ctl_chef_server-show-service-credentials>`

Your secrets file is located at ``/etc/opscode/private-chef-secrets.json``, so whenever you rotate your service credentials, or update your shared secrets, this file will contain the changes.

Supporting SAML-authentication in Chef Manage
=====================================================
To support SAML-authentication in Chef Manage, you can now filter users using ``external_authentication_uid`` in a GET request against the Chef server API. For example, to retrieve users where the ``external_authentication_uid`` is ``jane@doe.com``, do the following:

.. code-block:: none

   GET /users?external_authentication_uid=jane%40doe.com

What's Fixed
=====================================================
For the list of issues that were addressed for this release, please see the changelog on GitHub: https://github.com/chef/chef-server/blob/master/CHANGELOG.md
