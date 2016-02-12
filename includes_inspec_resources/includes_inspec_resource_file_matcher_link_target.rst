.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``link_target`` matcher tests if a file that is linked to this file exists at the specified path:

.. code-block:: ruby

   its('link_target') { should eq '/some/path/to/file' }
