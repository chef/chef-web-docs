.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use a function to help specify how rules are applied. A function may be used in ``when``, ``then``, and ``otherwise`` sections in rules. A function has the following syntax:

.. code-block:: ruby

   function_name(param1, param2, paramN)

.. note:: A function that is defined in the ``when`` section of a rule MUST return a Boolean value, or it will fail.
