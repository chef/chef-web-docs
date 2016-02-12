.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``postgres_session`` |inspec resource| block declares the username and password to use for the session, and then the command to be run:

.. code-block:: ruby

   sql = postgres_session('username', 'password')

   describe sql.query('SELECT * FROM pg_shadow WHERE passwd IS NULL;') do
     its('output') { should eq('') }
   end

where

* ``sql = postgres_session`` declares a username and password with permission to run the query
* ``sql.query('')`` contains the query to be run
* ``its('output') { should eq('') }`` compares the results of the query against the expected result in the test
