.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``ciphers`` matcher tests the named cipher:

.. code-block:: ruby

   its('ciphers') { should_not eq '/rc4/i' }

or:

.. code-block:: ruby

   describe ssl(port: 443).ciphers(/rc4/i) do
     it { should_not be_enabled }
   end
