.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``gem`` |inspec resource| block declares a package and (optionally) a package version:

.. code-block:: ruby

   describe gem('gem_package_name') do
     it { should be_installed }
   end

where

* ``('gem_package_name')`` must specify a |gem| package, such as ``'rubocop'``
* ``be_installed`` is a valid matcher for this |inspec resource|
