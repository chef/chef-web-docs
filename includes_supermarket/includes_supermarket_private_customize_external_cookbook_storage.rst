.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Cookbook artifacts---|tar gz| artifacts that are uploaded to |supermarket| when sharing a cookbook---can be stored either on the local filesystem of the |supermarket| node (``/var/opt/supermarket/data`` by default) or in an |amazon s3| bucket. To use an S3 bucket, configure the following attributes in the ``/recipes/default.rb`` recipe of the wrapper cookbook:

.. code-block:: ruby

   node.set['supermarket_omnibus']['config']['s3_access_key_id'] = false
   node.set['supermarket_omnibus']['config']['s3_bucket'] = 'supermarket'
   node.set['supermarket_omnibus']['config']['s3_access_key_id'] = 'yoursecretaccesskey'
