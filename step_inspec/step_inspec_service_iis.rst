.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if IIS service is both running and enabled:

.. code-block:: ruby

   describe service('W3SVC') do 
     it { should be_installed }
     it { should be_running }
   end
