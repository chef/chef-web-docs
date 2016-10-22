.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

When the ``guard_intrepreter`` common attribute is set to ``:powershell_script``, a string command will be evaluated as if this value were set to ``true``. This is because the behavior of this attribute is similar to the value of the ``"$?"`` expression common in UNIX interpreters. For example, this:
       
.. code-block:: ruby
       
   powershell_script 'make_safe_backup' do
     guard_interpreter :powershell_script
     code 'cp ~/data/nodes.json ~/data/nodes.bak'
     not_if 'test-path ~/data/nodes.bak'
   end

is similar to:

.. code-block:: ruby
       
   bash 'make_safe_backup' do
     code 'cp ~/data/nodes.json ~/data/nodes.bak'
     not_if 'test -e ~/data/nodes.bak'
   end
