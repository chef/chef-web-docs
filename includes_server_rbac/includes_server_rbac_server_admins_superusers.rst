.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Superuser accounts may not be managed by users who belong to the ``server-admins`` group. For example, Alice attempts to delete the ``pivotal`` superuser account:

.. code-block:: bash

   $ knife user delete pivotal -c ~/.chef/alice.rb

and the following error is returned:

.. code-block:: bash

   ERROR: You authenticated successfully to <chef_server_url> as user1
          but you are not authorized for this action
   Response: Missing read permission

Alice's action is unauthorized even with membership in the ``server-admins`` group.
