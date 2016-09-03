.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``shortname`` matcher names a specific package repository's group identifier. For example, if a repository's group name is "Directory Server", the corresponding group idenfier is typically "directory-server":

.. code-block:: ruby

   describe yum.repo('Directory Server') do
     its('shortname') { should eq 'directory-server' }
   end
