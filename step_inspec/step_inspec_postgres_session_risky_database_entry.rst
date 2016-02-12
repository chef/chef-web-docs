.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test for risky database entries:

.. code-block:: ruby

   describe postgres_session('my_user', 'password').query('SELECT count (*)
                 FROM pg_language
                 WHERE lanpltrusted = 'f'
                 AND lanname!='internal'
                 AND lanname!='c';') do
     its('output') { should eq(/^0/) }
   end

