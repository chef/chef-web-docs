.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following test shows how to audit machines to ensure that ``/etc/ssh`` is a directory:

.. code-block:: ruby

   control 'basic-1' do
     impact 1.0
     title '/etc/ssh should be a directory'
     desc '
       In order for OpenSSH to function correctly, its
       configuration path must be a folder.
     '
     describe file('/etc/ssh') do
       it { should be_directory }
     end
   end
