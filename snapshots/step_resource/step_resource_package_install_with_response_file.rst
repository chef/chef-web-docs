.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use of a ``response_file`` is only supported on Debian and Ubuntu at this time. Custom resources must be written to support the use of a ``response_file``, which contains debconf answers to questions normally asked by the package manager on installation. Put the file in ``/files/default`` of the cookbook where the package is specified and the chef-client will use the **cookbook_file** resource to retrieve it.

To install a package with a ``response_file``:

.. code-block:: ruby

   package 'sun-java6-jdk' do
     response_file 'java.seed'
   end
