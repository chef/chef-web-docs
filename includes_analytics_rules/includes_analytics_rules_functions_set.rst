.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use ``set()`` to set a user-defined value in the |json| object. A user-defined value always begins with ``#``. Prepend values saved by the ``set()`` function with ``user_defined_values`` to access them later from a ``notify()`` or ``alert()`` function.  Values that are not user-defined may not be modified.

The syntax for this function:

.. code-block:: ruby

   set(#variableToSet, valueToSet)

where:

* ``variableToSet`` is the location of a user-defined value
* ``valueToSet`` is the value

For example:

.. code-block:: ruby

   set(#organization_name, 'ponyville')

Later on in the same rule or another rule in the same group, do:

.. code-block:: ruby

   alert:warn("Check out the org name {{user_defined_values.#organization_name}}")
