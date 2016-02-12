.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A resource describes the state of something by declaring an action:

.. code-block:: ruby
       
   file 'hello.txt' do
     action :create
   end
