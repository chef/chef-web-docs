.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To enable remote login on Mac OS X:

.. code-block:: ruby

   execute 'enable ssh' do 
     command '/usr/sbin/systemsetup -setremotelogin on'
     not_if '/usr/sbin/systemsetup -getremotelogin | /usr/bin/grep On'
     action :run
   end
