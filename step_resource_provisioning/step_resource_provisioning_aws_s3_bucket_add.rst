.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To add an Amazon S3 bucket:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'
   with_driver 'aws'
   
   aws_s3_bucket 'aws-bucket' do
     enable_website_hosting true
     website_options :index_document => {
       :suffix => "index.html"
     },
     :error_document => {
       :key => "not_found.html"
     }
   end
