.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``pip`` |inspec resource| block declares a package and (optionally) a package version:

.. code-block:: ruby

   describe pip('Jinja2') do
     it { should be_installed }
   end

where

* ``'Jinja2'`` is the name of the package
* ``be_installed`` tests to see if the ``Jinja2`` package is installed
