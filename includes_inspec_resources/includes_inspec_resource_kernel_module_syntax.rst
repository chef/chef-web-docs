.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``kernel_module`` |inspec resource| block declares a module name, and then tests if that module is a loadable kernel module:

.. code-block:: ruby

   describe kernel_module('module_name') do
     it { should be_loaded }
   end

where

* ``'module_name'`` must specify a kernel module, such as ``'bridge'``
* ``{ should be_loaded }`` tests if the module is a loadable kernel module
