.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``aws_cloudsearch_domain`` resource block manages an |amazon cloudsearch| domain. For example:

.. code-block:: ruby

   aws_cloudsearch_domain 'ref-cs-domain' do
     instance_type 'search.m1.small'
     partition_count 2
     replication_count 2
     index_fields [{:index_field_name => 'foo',
                    :index_field_type => 'text'}]
   end

The full syntax for all of the properties that are available to the ``aws_cloudsearch_domain`` resource is:

.. code-block:: ruby

   aws_cloudsearch_domain 'name' do
     access_policies               String
     cloudsearch_api_version       Integer
     index_fields                  Array
     instance_type                 String
     mutli_az                      TrueClass, FalseClass
     partition_count               Integer
     replication_count             Integer
   end

where 

* ``aws_cloudsearch_domain`` is the resource
* ``name`` is the name of the resource block
* ``access_policies``, ``cloudsearch_api_version``, ``index_fields``, ``instance_type``, ``mutli_az``, ``partition_count``, and ``replication_count`` are properties of this resource, with the |ruby| type shown. |see attributes|
