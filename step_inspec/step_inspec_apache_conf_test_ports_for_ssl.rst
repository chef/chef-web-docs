.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test ports for SSL:

.. code-block:: ruby

   describe apache_conf do
     its('Listen') { should eq '443'}
   end
