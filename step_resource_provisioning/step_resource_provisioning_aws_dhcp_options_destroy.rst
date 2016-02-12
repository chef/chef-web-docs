.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To delete an option set:

.. code-block:: ruby

   aws_dhcp_options 'ref-dhcp-options' do
     action :destroy
   end
