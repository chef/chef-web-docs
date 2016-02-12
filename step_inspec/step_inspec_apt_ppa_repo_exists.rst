.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if a PPA repository exists and is enabled:

.. code-block:: ruby

   describe apt('ppa:nginx/stable') do
     it { should exist }
     it { should be_enabled }
   end
