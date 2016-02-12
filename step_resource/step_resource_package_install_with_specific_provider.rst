.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To install a package using a specific provider:

.. code-block:: ruby

   package 'tar' do
     action :install
     source '/tmp/tar-1.16.1-1.rpm'
     provider Chef::Provider::Package::Rpm
   end
