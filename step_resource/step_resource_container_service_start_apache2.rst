.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To start apache2:

.. code-block:: ruby
   
   service 'apache2' do
     action :start
   end
   
   container_service 'apache2' do
     command '/usr/sbin/apache2 -D FOREGROUND'
   end
