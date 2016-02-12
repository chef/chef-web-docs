.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test the DHCP Server feature:

.. code-block:: ruby

   describe windows_feature('DHCP Server') do
     it{ should be_installed }
   end
