.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use ``when`` to define an expression. Multiple expressions may be joined using ``and`` and ``or``. Expressions may be grouped using parentheses (``( )``). Expressions may use nested function calls on either side of the expression. The following operators may be used:

.. list-table::
   :widths: 20 400
   :header-rows: 1

   * - Operator
     - Description
   * - ``=``
     - |ruby equal|
   * - ``!=``
     - not equal to
   * - ``>``
     - |ruby greater|
   * - ``<``
     - |ruby less|
   * - ``>=``
     - |ruby greater_optimistic|
   * - ``<=``
     - |ruby less_or_equal|
   * - ``=~``
     - a regular expression
   * - ``not``
     - negates the expression

For example:

.. code-block:: ruby

   rule on action when
     max(1000, data.some_value) = 1000
   then
     set(#some_value, data.some_other_value)
   end

or:

.. code-block:: ruby

   rule on action when
     some_value > 1000 and 
       (max(data.some_other_value, max(100,data.max_field)) = 1000 or data.foo='Some Value')
   then
     set(#some_value, data.some_other_value)
   end
