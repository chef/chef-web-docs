.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Any resource that passes a string command may also specify which resource will be used to evaluate the command (by using the ``guard_intrepreter`` property). For example, to evaluate a command using the |resource script_perl| resource:

.. code-block:: ruby

   resource 'name' do
     guard_interpreter :perl
     # code
   end
