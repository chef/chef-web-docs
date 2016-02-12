.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To define an AMI instance type:

.. code-block:: ruby

   aws_launch_configuration 'ref-launch-configuration' do
     image 'ref-machine_image1'
     instance_type 't1.micro'
     options security_groups: 'ref-sg1'
   end
