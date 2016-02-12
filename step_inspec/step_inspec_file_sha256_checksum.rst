.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test an SHA-256 checksum:

.. code-block:: bash

   require 'digest'
   cpuinfo = file('/proc/cpuinfo').content
   
   sha256sum = Digest::SHA256.hexdigest(cpuinfo)
   
   describe file('/proc/cpuinfo') do
     its('sha256sum') { should eq sha256sum }
   end
