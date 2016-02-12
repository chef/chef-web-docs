.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``be_file`` matcher tests if the file exists as a file. This can be useful with configuration files like ``/etc/passwd`` where there typically is not an associated file extension---``passwd.txt``:

.. code-block:: ruby

   it { should be_file }
