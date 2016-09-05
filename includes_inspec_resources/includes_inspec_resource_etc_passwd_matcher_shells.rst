.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``shells`` matcher tests the absolute path of a shell (or command) to which a user has access:

.. code-block:: ruby

   its('shells') { should_not include 'user' }

or to find all users with the nologin shell:

.. code-block:: ruby

   describe passwd.shells(/nologin/) do
     its('users') { should_not include 'my_login_user' }
   end
