.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test the contents of a file for MD5 requirements:

.. code-block:: bash

   describe file(hba_config_file) do
     its('content') { should match '/local\s.*?all\s.*?all\s.*?md5/' }
     its('content') { should match '%r{/host\s.*?all\s.*?all\s.*?127.0.0.1\/32\s.*?md5/}' }
     its('content') { should match '%r{/host\s.*?all\s.*?all\s.*?::1\/128\s.*?md5/}' }
   end
