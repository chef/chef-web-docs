.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To delete an Amazon S3 bucket:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'
   with_driver 'aws'
   
   aws_s3_bucket 'aws-bucket' do
     action :destroy
   end
