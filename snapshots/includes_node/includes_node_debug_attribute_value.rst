.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``debug_value`` method to discover the location within the attribute precedence hierarchy from which a particular attribute (or sub-attribute) is set. This method is available when running chef-shell in chef-client mode:

.. code-block:: bash

   $ chef-shell -z

For example, the following attributes exist in a cookbook. Some are defined in a role file:

.. code-block:: ruby

   default_attributes 'test' => {'source' => 'role default'}
   override_attributes 'test' => {'source' => 'role override'}

And others are defined in an attributes file:

.. code-block:: ruby

   default[:test][:source]  = 'attributes default'
   set[:test][:source]      = 'attributes normal'
   override[:test][:source] = 'attributes override'

To debug the location in which the value of ``node[:test][:source]`` is set, use chef-shell and run a command similar to:

.. code-block:: none

   $ pp node.debug_value('test', 'source')

This will pretty-print return all of the attributes and sub-attributes as an array of arrays; ``:not_present`` is returned for any attribute without a value:

.. code-block:: bash

   [['set_unless_enabled?', false],
    ['default', 'attributes default'],
    ['env_default', :not_present],
    ['role_default', 'role default'],
    ['force_default', :not_present],
    ['normal', 'attributes normal'],
    ['override', 'attributes override'],
    ['role_override', 'role override'],
    ['env_override', :not_present],
    ['force_override', :not_present],
    ['automatic', :not_present]]

where

* ``set_unless_enabled`` indicates if the attribute collection is in ``set_unless`` mode; this typically returns ``false``
* Each attribute type is listed in order of precedence
* Each attribute value shown is the value that is set for that precedence level
* ``:not_present`` is shown for any attribute precedence level that has no attributes

A `blog post by Joshua Timberman <http://jtimberman.housepub.org/blog/2014/09/02/chef-node-dot-debug-value/>`_ provides another example of using this method.
