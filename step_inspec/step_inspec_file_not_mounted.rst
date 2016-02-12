.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test that a file is not mounted:

.. code-block:: bash

   describe file('/proc/cpuinfo') do
     it { should_not be_mounted }
   end
