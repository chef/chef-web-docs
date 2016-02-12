.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``kernel_parameter`` |inspec resource| block declares a parameter and then a value to be tested:

.. code-block:: ruby

   describe kernel_parameter('path.to.parameter') do
     its('value') { should eq 0 }
   end

where

* ``'kernel.parameter'`` must specify a kernel parameter, such as ``'net.ipv4.conf.all.forwarding'``
* ``{ should eq 0 }`` states the value to be tested
