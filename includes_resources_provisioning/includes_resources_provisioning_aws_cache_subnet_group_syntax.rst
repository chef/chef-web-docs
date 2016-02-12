.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``aws_cache_subnet_group`` resource block manages cache subnet groups in |amazon aws|. For example:

.. code-block:: ruby

   aws_cache_subnet_group 'name' do
     description 'Description of cache subnet group.'
     subnets [ 'subnet', 'subnet' ]
   end

The full syntax for all of the properties that are available to the ``aws_cache_subnet_group`` resource is:

.. code-block:: ruby

   aws_cache_subnet_group 'name' do
     description                   String
     group_name                    String  # defaults to 'name' if not specified
     subnets                       String, Array
   end

where 

* ``aws_cache_subnet_group`` is the resource
* ``name`` is the name of the resource block (and is the same as the ``group_name`` property if ``group_name`` is not specified in the resource block)
* ``description`` and ``subnets`` are properties of this resource, with the |ruby| type shown. |see attributes|
