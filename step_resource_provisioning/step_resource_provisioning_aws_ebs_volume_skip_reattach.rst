.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To skip a reattach attempt:

.. code-block:: ruby

   aws_ebs_volume 'ref-volume-ebs' do
     machine 'ref-machine-2'
     device '/dev/xvdf'
   end
