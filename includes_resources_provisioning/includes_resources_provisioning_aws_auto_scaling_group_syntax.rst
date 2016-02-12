.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``aws_auto_scaling_group`` resource block declares auto scaling groups used for |amazon ec2| instances. For example:

.. code-block:: ruby

   aws_auto_scaling_group 'name' do
     availability_zones ['us-west-1a']
     desired_capacity 2
     min_size 1
     max_size 3
     launch_configuration 'ref-launch-configuration'
     load_balancers 'ref-load-balancer'
     options subnets: 'ref-subnet'
   end

The full syntax for all of the properties that are available to the ``aws_auto_scaling_group`` resource is:

.. code-block:: ruby

   aws_auto_scaling_group 'name' do
     availability_zones            Array
     desired_capacity              Integer
     min_size                      Integer
     max_size                      Integer
     launch_configuration          String
     load_balancers                Array
     options                       Hash
   end

where 

* ``aws_auto_scaling_group`` is the resource
* ``name`` is the name of the resource block and also the name of the auto scaling group in |amazon ec2|
* ``availability_zones``, ``desired_capacity``, ``max_size``, ``min_size``, ``launch_configuration``, ``load_balancers``, and ``options`` are properties of this resource, with the |ruby| type shown. |see attributes|
