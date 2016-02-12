.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following test shows how to audit machines running |postgresql| to ensure that passwords are not empty:

.. code-block:: ruby

   control 'postgres-7' do
     impact 1.0
     title 'Don't allow empty passwords'
     desc '
       ...
     '
     describe postgres_session('user', 'pass').query("SELECT * FROM pg_shadow WHERE passwd IS NULL;") do
       its('output') { should eq('') }
     end
   end
