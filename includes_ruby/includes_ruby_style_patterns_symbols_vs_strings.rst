.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Prefer strings over symbols, because they're easier to read and you don't need to explain to non-Rubyists what a symbol is. Please retrofit old cookbooks as you come across them.

Right:

.. code-block:: ruby

   default['foo']['bar'] = 'baz'

Wrong:

.. code-block:: ruby

   default[:foo][:bar] = 'baz'
