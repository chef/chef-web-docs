.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``npm`` |inspec resource| block declares a package and (optionally) a package version:

.. code-block:: ruby

   describe gem('npm_package_name') do
     it { should be_installed }
   end

where

* ``('npm_package_name')`` must specify a |npm| package, such as ``'bower'`` or ``'statsd'``
* ``be_installed`` is a valid matcher for this |inspec resource|
