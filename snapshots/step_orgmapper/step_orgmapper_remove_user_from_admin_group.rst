.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To remove a user from an organization's admin group:

.. code-block:: ruby

   orgmapper:0> ORGS['ORGNAME'].remove_user_from_group('USERNAME', 'admins')