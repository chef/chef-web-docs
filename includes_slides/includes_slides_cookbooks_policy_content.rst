.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Content is data that may change independent of policy changes. For example, adding content and setting permissions:

.. code-block:: ruby
       
   file '/etc/motd' do
     content 'Property of COMPANY NAME'
     action :create
     mode '0644'
     owner 'root'
     group 'root'
   end
