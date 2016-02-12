.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test SSH configuration settings:

.. code-block:: ruby

   describe ssh_config do
     its('cipher') { should contain '3des' }
     its('port') { should '22' }
     its('hostname') { should include('example.com') }
   end
