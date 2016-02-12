.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``md5sum`` matcher tests if the |md5| checksum for a file matches the specified value:

.. code-block:: ruby

   its('md5sum') { should eq '3329x3hf9130gjs9jlasf2305mx91s4j' }
