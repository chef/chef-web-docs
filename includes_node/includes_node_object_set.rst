.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Attributes for node objects can be set by cookbooks (and recipes), environments, roles, and by the node itself. When a node attribute is set from a recipe, use the ``node.set`` method:

.. code-block:: ruby

   node.set['some_attribute'] = 'Some Value' + 'Some other value'
   node.set['some_attribute']['sub_attribute'] = 'Sub attribute Value'

This approach is most useful when a value needs to be calculated or when data needs to be stored on the node so that it persists for the next |chef client| run.
