.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Single value vs. array:

.. code-block:: ruby

   describe passwd.uids(0) do
     its('users') { should cmp 'root' }
     its('users') { should cmp ['root'] }
   end
