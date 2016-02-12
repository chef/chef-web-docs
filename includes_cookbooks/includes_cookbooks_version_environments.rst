.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

An environment can use version constraints to specify a list of allowed cookbook versions by specifying the cookbook's name, along with the version constraint. For example:

.. code-block:: ruby

   cookbook 'apache2', '~> 1.2.3'

Or:

.. code-block:: ruby

   cookbook 'runit', '= 4.2.0'

If a cookbook is not explicitly given a version constraint the environment will assume the cookbook has no version constraint and will use any version of that cookbook with any node in the environment.
