.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example creates symbolic links from two files in the ``/vol/webserver/cert/`` directory to files located in the ``/etc/ssl/certs/`` directory:

.. code-block:: ruby

   link '/vol/webserver/cert/server.crt' do
     to '/etc/ssl/certs/ssl-cert-name.pem'
   end
   
   link '/vol/webserver/cert/server.key' do
     to '/etc/ssl/certs/ssl-cert-name.key'
   end
