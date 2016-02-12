.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To create a directory:

.. code-block:: ruby

   directory '/tmp/something' do
     owner 'root'
     group 'root'
     mode '0755'
     action :create
   end
