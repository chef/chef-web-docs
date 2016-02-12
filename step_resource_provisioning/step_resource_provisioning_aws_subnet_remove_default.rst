.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To remove the default subnet:

.. code-block:: ruby

   aws_subnet 'default' do
     availability_zone availability_zone
     action :destroy
   end
