.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test users on multiple platforms:

The |nginx| user is typically ``www-data``, but on |centos| it's ``nginx``. The following example shows how to test for the |nginx| user with a single test, but accounting for all platforms:

.. code-block:: ruby

   web_user = 'www-data'
   web_user = 'nginx' if os[:family] == 'centos'

   describe user(web_user) do
     it { should exist }
   end
