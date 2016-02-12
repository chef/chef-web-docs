.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To create and attach an EBS volume:

.. code-block:: ruby

   aws_ebs_volume 'ref-volume-ebs-2' do
     availability_zone 'a'
     size 1
     machine 'ref-machine-1'
     device '/dev/xvdf'
   end
