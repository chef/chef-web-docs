.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


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
