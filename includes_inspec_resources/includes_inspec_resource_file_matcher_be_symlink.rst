.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``be_symlink`` matcher tests if the file exists as a symbolic, or soft link that contains an absolute or relative path reference to another file:

.. code-block:: ruby

   it { should be_symlink }
