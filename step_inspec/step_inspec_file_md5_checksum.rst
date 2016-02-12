.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test an MD5 checksum:

.. code-block:: bash

   require 'digest'
   cpuinfo = file('/proc/cpuinfo').content
   
   md5sum = Digest::MD5.hexdigest(cpuinfo)
   
   describe file('/proc/cpuinfo') do
     its('md5sum') { should eq md5sum }
   end
