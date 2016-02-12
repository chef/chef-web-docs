.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test for PostgreSQL database running a RC, development, or beta release:

.. code-block:: ruby

   describe command('psql -V') do
     its('stdout') { should eq '/RC/' }
     its('stdout') { should_not eq '/DEVEL/' }
     its('stdout') { should_not eq '/BETA/' }
   end
