.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To define an auto scaling group:

The following example uses the ``aws_launch_config`` resource to create an image and instance type, and then the ``aws_auto_scaling_group`` resource to build out a group of machines:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'
   
   with_driver 'aws::eu-west-1' do
     aws_launch_config 'launch-config-name' do
       image 'ami-f0b11187'
       instance_type 't1.micro'
     end
   
     aws_auto_scaling_group 'auto-scaling-group-name' do
       desired_capacity 3
       min_size 1
       max_size 5
       launch_config 'launch-config-name'
     end
   end
