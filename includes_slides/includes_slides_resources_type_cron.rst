.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A cron job that should be configured:

.. code-block:: ruby
       
   cron 'restart webserver' do
     hour '2'
     minute '0'
     command 'service httpd restart'
   end
