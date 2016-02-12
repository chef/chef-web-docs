.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This |inspec resource| matches any service that is listed in the ``inetd.conf`` file. You may want to ensure that specific services do not listen via ``inetd.conf``:

.. code-block:: ruby

   its('shell') { should eq nil }

or:

.. code-block:: ruby

   its('netstat') { should eq nil }

or:

.. code-block:: ruby

   its('systat') { should eq nil }

For example:

.. code-block:: ruby

   describe inetd_conf do
     its('shell') { should eq nil }
     its('login') { should eq nil }
     its('exec') { should eq nil }
   end
