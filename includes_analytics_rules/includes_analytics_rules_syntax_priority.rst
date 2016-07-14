.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``with priority`` statement to specify a positive or negative integer that defines the relative priority of a rules group as compared to all other rules groups. For example:

.. code-block:: ruby

   rules 'rule name'
     with priority=100
       rule on action ...
     ...
   end

A rules group with a higher integer value will have priority over any rules groups with lower integer values.
