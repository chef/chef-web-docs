.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Environment attributes that are used with roles can be overridden. Typically, this is done by using attribute precedence, but sometimes it may be necessary to ensure that specific attributes are used based on the presence of specific environments. This type of scenario is best addressed in using a recipe that relies on a top-level key that is stored in a data bag.

For example, to retrieve a value from a data bag based on a specific environment:

.. code-block:: ruby

   mything = data_bag_item('things', 'mything')
   attribute_i_want = mything[node.chef_environment]
