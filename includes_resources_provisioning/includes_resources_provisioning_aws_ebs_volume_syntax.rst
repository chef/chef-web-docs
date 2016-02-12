.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``aws_ebs_volume`` resource block manages |amazon ebs| volumes. For example:

.. code-block:: ruby

   aws_ebs_volume 'name' do
     machine 'ref-machine1'
     availability_zone 'a'
     size 100
     iops 3000
     volume_type 'io1'
     encrypted true
     device '/dev/sda2'
     aws_tags :chef_type => 'aws_ebs_volume'
   end

The full syntax for all of the properties that are available to the ``aws_ebs_volume`` resource is:

.. code-block:: ruby

   aws_ebs_volume 'name' do
     availability_zone             String
     device                        String
     encrypted                     TrueClass, FalseClass
     iops                          Integer
     machine                       String
     size                          Integer
     snapshot                      String
     volume_id                     String
     volume_type                   String
   end

where 

* ``aws_ebs_volume`` is the resource
* ``name`` is the name of the resource block and also the name of a block-level storage device that is attached to an |amazon ec2| instance
* ``availability_zone``, ``device``, ``encrypted``, ``iops``, ``machine``, ``size``, and ``volume_type`` are properties of this resource, with the |ruby| type shown. |see attributes|
