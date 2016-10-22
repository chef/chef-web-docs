.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To destroy a named group of machines along with keys:

The following example destroys an Amazon Elastic Block Store (EBS) volume for the specified batch of machines, along with any associated public and/or private keys:

.. code-block:: ruby

   ['ref-volume-ebs', 'ref-volume-ebs-2'].each { |volume|
     aws_ebs_volume volume do
       action :destroy
     end
   }
   
   machine_batch do
     machines 'ref-machine-1', 'ref-machine-2'
     action :destroy
   end
   
   aws_key_pair 'ref-key-pair-ebs' do
     action :destroy
   end
