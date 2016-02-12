.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``yum`` |inspec resource| block declares a package repo, tests if the package repository is present, and if it that package repository is a valid package source (i.e. "is enabled"):

.. code-block:: ruby

   describe yum.repo('name') do
     it { should exist }
     it { should be_enabled }
   end

where

* ``repo('name')`` is the (optional) name of a package repo, using either a full identifier (``'updates/7/x86_64'``) or a short identifier (``'updates'``)
