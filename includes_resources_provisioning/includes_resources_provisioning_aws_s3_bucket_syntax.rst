.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``aws_s3_bucket`` resource block manages |amazon s3| buckets. For example:

.. code-block:: ruby

   aws_s3_bucket 'name' do
     enable_website_hosting true
     options({ :acl => 'private' })
     website_options :index_document => { :suffix => 'index.html' },
                     :error_document => { :key => 'not_found.html' }
   end

The full syntax for all of the properties that are available to the ``aws_s3_bucket`` resource is:

.. code-block:: ruby

   aws_s3_bucket 'name' do
     enable_website_hosting        TrueClass, FalseClass
     options                       Hash
     website_options               Hash
   end

where 

* ``aws_s3_bucket`` is the resource
* ``name`` is the name of the resource block and also the name of an |amazon s3| bucket
* ``enable_website_hosting``, and ``options`` are properties of this resource, with the |ruby| type shown. |see attributes|
