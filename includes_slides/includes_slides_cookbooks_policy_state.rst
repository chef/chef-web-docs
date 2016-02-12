.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


State is policy that describes the resource. For example, create the ``motd`` file if it does not already exist:

.. code-block:: ruby
       
   file '/etc/motd' do
     content 'Property of COMPANY NAME'
     action :create
     mode '0644'
     owner 'root'
     group 'root'
   end
