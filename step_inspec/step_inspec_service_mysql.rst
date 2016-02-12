.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if the mysql service is both running and enabled:

.. code-block:: ruby

   describe service('mysqld') do
     it { should be_enabled }
     it { should be_running }
   end
