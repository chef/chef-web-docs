.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following is an example of using the ``include_recipe`` method to include a recipe in a recipe:

.. code-block:: ruby

   include_recipe "java::#{node['java']['install_flavor']}"
