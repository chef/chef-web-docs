.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``bond`` |inspec resource| block declares a bonded network interface, and then specifies the properties of that bonded network interface to be tested:

.. code-block:: ruby

   describe bond('name') do
     it { should exist }
   end

where

* ``'name'`` is the name of the bonded network interface
* ``{ should exist }`` is a valid matcher for this |inspec resource|
