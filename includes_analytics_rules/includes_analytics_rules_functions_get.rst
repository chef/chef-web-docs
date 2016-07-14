.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use ``get()`` to identify a field, and then identify an associated value.

The syntax for this function:

.. code-block:: ruby

   get(variableToGet, valueToSet OR defaultIfMissing)

where:

* ``variableToGet`` specifies the field to look for
* ``valueToSet`` specifies the value to use
* ``defaultIfMissing`` specifies to use the default value if there is no user-defined value

For example:

.. code-block:: ruby

   rule on action when
     get(foo, false) = false
   then
     notify('some_alias')
   end

will pass if ``foo`` is missing in the |json| object.
