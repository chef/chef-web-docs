.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``be_directory`` matcher tests if the file exists as a directory, such as ``/etc/passwd``, ``/etc/shadow``, or ``/var/log/httpd``:

.. code-block:: ruby

   it { should be_directory }
