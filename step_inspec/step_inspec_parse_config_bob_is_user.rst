.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test that bob is a user:

.. code-block:: ruby

   describe parse_config(data, { multiple_values: true }) do
     its('users') { should include 'bob'}
   end
