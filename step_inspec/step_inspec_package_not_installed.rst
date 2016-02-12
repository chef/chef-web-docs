.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test that a package is not installed:

.. code-block:: ruby

   describe package('some_package') do
     it { should_not be_installed }
   end
