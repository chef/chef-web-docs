.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A file named ``hello.txt`` should be created with content of ``Hello, world!``, permissions of ``0644``, owned by the ``chef`` user and ``chef`` group:

.. code-block:: ruby
       
   file 'hello.txt' do
     action :create
     content 'Hello, world!'
     mode '0644'
     owner 'chef'
     group 'chef'
   end
