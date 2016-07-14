.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``otherwise`` statement to specify what to do when a rule in the ``when`` statement is matched, but is not handled by the ``then`` statement. For example:

.. code-block:: ruby

   rule on action when
     data.name='app1'
   then
     set(#foo, '100')  
   otherwise
     set(#foo, '200")  
   end

When the name matches ``app1``, ``#foo`` will be set to ``100`` and if the name does not match ``app1``, ``#foo`` will be set to ``200``.
