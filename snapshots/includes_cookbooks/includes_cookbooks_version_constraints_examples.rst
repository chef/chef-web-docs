.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

For example, a version constraint for "equals version 1.0.7" is expressed like this:

.. code-block:: ruby

   = 1.0.7

A version constraint for "greater than version 1.0.2" is expressed like this:

.. code-block:: ruby

   > 1.0.2

An optimistic version constraint is one that looks for versions greater than or equal to the specified version. For example:

.. code-block:: ruby

   >= 2.6.5

will match cookbooks greater than or equal to 2.6.5, such as 2.6.5, 2.6.7 or 3.1.1.

A pessimistic version constraint is one that will find the upper limit version number within the range specified by the minor version number or patch version number. For example, a pessimistic version constraint for minor version numbers:

.. code-block:: ruby

   ~> 2.6

will match cookbooks that are greater than or equal to version 2.6, but less than version 3.0. 

Or, a pessimistic version constraint for patch version numbers:

.. code-block:: ruby

   ~> 2.6.5

will match cookbooks that are greater than or equal to version 2.6.5, but less than version 2.7.0. 

Or, a pessimistic version constraint that matches cookbooks less than a version number:

.. code-block:: ruby

   < 2.3.4

or will match cookbooks less than or equal to a specific version number:

.. code-block:: ruby

   <= 2.6.5
