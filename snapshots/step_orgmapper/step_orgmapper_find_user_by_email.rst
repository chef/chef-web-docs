.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To find a user based on an email address:

.. code-block:: ruby

   orgmapper:0 > USERS.select{|u| u.email == 'user@company.com'}

where ``user@company.com`` is the email address for the user.