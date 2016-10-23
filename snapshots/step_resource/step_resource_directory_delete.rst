.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To delete a directory:

.. code-block:: ruby

   directory '/tmp/something' do
     recursive true
     action :delete
   end
