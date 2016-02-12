.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``content`` matcher tests if contents in the file match the value specified in the test. The values of the ``content`` matcher are arbitrary and depend on the file type being tested and also the type of information that is expected to be in that file:

.. code-block:: ruby

   its('content') { should contain 'value' }

The following complete example tests the ``pg_hba.conf`` file in |postgresql| for |md5| requirements.  The tests look at all ``host`` and ``local`` settings in that file, and then compare the |md5| checksums against the values in the test:

.. code-block:: bash

   describe file(hba_config_file) do
     its('content') { should match '/local\s.*?all\s.*?all\s.*?md5/' }
     its('content') { should match '%r{/host\s.*?all\s.*?all\s.*?127.0.0.1\/32\s.*?md5/}' }
     its('content') { should match '%r{/host\s.*?all\s.*?all\s.*?::1\/128\s.*?md5/}' }
   end
