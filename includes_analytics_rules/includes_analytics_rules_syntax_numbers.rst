.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Numbers may be positive or negative integers or floating point values.

* The valid range for integers is ``-9223372036854775808`` to ``9223372036854775807``
* The valid range for floating point numbers is ``4.9E-324`` to ``1.7976931348623157E308``; scientific notation is not supported and rounding will occur outside of this range

Numbers may be compared with the following operators:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Operator
     - Description
   * - ``=``
     - Equality.
   * - ``!=``
     - Inequality.
   * - ``>``
     - Greater than.
   * - ``>=``
     - Greater than equal.
   * - ``<``
     - Less than.
   * - ``<=``
     - Less than equal.

.. note:: If a number is compared to a non-number, the rule will not match and an error is logged.
	 
For example, all of the following are valid numbers:

.. code-block:: ruby

   1

or:

.. code-block:: ruby

   -99999999

or:

.. code-block:: ruby

   1.99999

or:

.. code-block:: ruby

   -999999.000123

For example:

.. code-block:: bash

   rules 'Match control groups with failures'
     rule on run control group
       when
         name = 'mysql audit' and number_failed > 0
       then
         alert:error('Control group failures detected')
     end
   end
