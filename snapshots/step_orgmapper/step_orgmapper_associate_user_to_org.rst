.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To associate a user to an orgazation:

Ensure that the user and organization already exist and then do something like:

.. code-block:: ruby

   orgmapper:0 > OrgMapper::Associator.associate_user(ORGS['ORGNAME'], USERS['USERNAME'])

where ``ORGNAME`` is the name of the organization and ``USERNAME`` is the name of the user.
