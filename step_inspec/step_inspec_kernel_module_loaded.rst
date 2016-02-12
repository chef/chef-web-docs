.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if a module is loaded:

.. code-block:: ruby

   describe kernel_module('bridge') do
     it { should be_loaded }
   end
