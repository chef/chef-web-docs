=====================================================
Release Notes: Chef Server 12.5
=====================================================

.. tag chef_index

Chef is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure. Each organization is comprised of one (or more) workstations, a single server, and every node that will be configured and maintained by the chef-client. Cookbooks (and recipes) are used to tell the chef-client how each node in your organization should be configured. The chef-client (which is installed on every node) does the actual configuration.

.. end_tag

What's New
=====================================================
The following items are new for Chef server 12.5:

* **New group for key-related Chef server API endpoints** The ``public_key_read_access`` group defines which users and clients have read permissions to key-related endpoints in the Chef server API.

public_key_read_access
=====================================================
.. tag server_rbac_permissions_default_public_key_read_access

The ``public_key_read_access`` group controls which users and clients have :doc:`read permissions to the following endpoints </api_chef_server>`:

* GET /clients/CLIENT/keys
* GET /clients/CLIENT/keys/KEY
* GET /users/USER/keys 
* GET /users/USER/keys/

By default, the ``public_key_read_access`` assigns all members of the ``users`` and ``clients`` group permission to these endpoints:

.. list-table::
   :widths: 160 100 100 100 100 100
   :header-rows: 1

   * - Group
     - Create
     - Delete
     - Grant
     - Read
     - Update
   * - admins
     - no
     - no
     - no
     - no
     - no
   * - clients
     - yes
     - yes
     - yes
     - yes
     - yes
   * - users
     - yes
     - yes
     - yes
     - yes
     - yes

.. end_tag

What's Fixed
=====================================================
For the list of issues that were addressed for this release, please see the changelog on GitHub: https://github.com/chef/chef-server/blob/master/CHANGELOG.md
