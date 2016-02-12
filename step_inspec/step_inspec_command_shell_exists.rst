.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if the command shell exists:

.. code-block:: ruby

   describe command('/bin/sh').exist? do
     it { should eq true }
   end
