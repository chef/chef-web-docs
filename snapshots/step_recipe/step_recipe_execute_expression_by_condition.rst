.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

An unless expression can be used to execute code when a condition returns a false value (effectively, an unless expression is the opposite of an if statement).

To use an expression to execute when a condition returns a false value:

.. code-block:: ruby

   unless node[:platform_version] == "5.0"
     # do stuff on everything but 5.0
   end
