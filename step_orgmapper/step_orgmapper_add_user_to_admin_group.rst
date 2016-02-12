.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To add a user to an organization's admin group:

.. code-block:: ruby

   orgmapper:0> g = ORGS['ORGNAME'].groups['admins']
   orgmapper:0> g.add_actor(USERS['USERNAME'])
   orgmapper:0> g.save

where ``ORGNAME`` is the name of the organization and ``USERNAME`` is the name of the user.
