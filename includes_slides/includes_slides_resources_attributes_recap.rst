.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The TYPE named NAME should be ACTION'd with ATTRIBUTES:

.. code-block:: ruby
       
   file 'hello.txt' do
     action :create
     content 'Hello, world!'
     mode '0644'
     owner 'chef'
     group 'chef'
   end
