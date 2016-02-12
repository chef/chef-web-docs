.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To delete a security group:

.. code-block:: ruby

   aws_security_group 'test-sg' do
     vpc 'test-vpc'
     action :delete
   end	
