.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``directory`` |inspec resource| block declares the location of the directory to be tested, and then one (or more) matchers:

.. code-block:: ruby

   describe directory('path') do
     it { should MATCHER 'value' }
   end
