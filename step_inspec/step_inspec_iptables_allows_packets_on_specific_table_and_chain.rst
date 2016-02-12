.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if the IP table allows a packet through, for a specific table and chain:

.. code-block:: ruby

   describe iptables(table:'mangle', chain: 'input') do
     it { should have_rule('-P INPUT ACCEPT') }
   end
