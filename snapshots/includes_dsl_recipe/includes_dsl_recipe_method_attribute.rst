.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``attribute?`` method to ensure that certain actions only execute in the presence of a particular node attribute. The ``attribute?`` method will return true if one of the listed node attributes matches a node attribute that is detected by Ohai during every chef-client run. 

The syntax for the ``attribute?`` method is as follows:

.. code-block:: ruby

   attribute?('name_of_attribute')

For example: 

.. code-block:: ruby

   if node.attribute?('ipaddress')
     # the node has an ipaddress
   end
