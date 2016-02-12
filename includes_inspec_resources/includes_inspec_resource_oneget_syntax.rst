.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``oneget`` |inspec resource| block declares a package and (optionally) a package version:

.. code-block:: ruby

   describe oneget('name') do
     it { should be_installed }
   end

where

* ``('name')`` must specify the name of a package, such as ``'VLC'``
* ``be_installed`` is a valid matcher for this |inspec resource|
