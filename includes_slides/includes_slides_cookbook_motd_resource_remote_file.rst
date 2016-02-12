.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the |resource remote_file| resource when a file is stored at a remote location, such as on the web:

.. code-block:: ruby
       
   file '/etc/motd' do
     url 'http://some.where.com/motd'
     action :create
     mode '0644'
     owner 'root'
     group 'root'
   end
