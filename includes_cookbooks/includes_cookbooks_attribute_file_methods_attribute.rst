.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A useful method that is related to attributes is the ``attribute?`` method. This method will check for the existence of an attribute, so that processing can be done in an attributes file or recipe, but only if a specific attribute exists.

Using ``attribute?()`` in an attributes file:

.. code-block:: ruby

   if attribute?('ec2')
     # ... set stuff related to EC2
   end

Using ``attribute?()`` in a recipe:

.. code-block:: ruby

   if node.attribute?('ec2')
     # ... do stuff on EC2 nodes
   end
