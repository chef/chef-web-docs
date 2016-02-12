.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``type`` matcher tests if the first letter of the file's mode string contains one of the following characters:

* ``-`` or ``f`` (the file is a file); use ``'file`` to test for this file type
* ``d`` (the file is a directory); use ``'directory`` to test for this file type
* ``l`` (the file is a symbolic link); use ``'link`` to test for this file type
* ``p`` (the file is a named pipe); use ``'pipe`` to test for this file type
* ``s`` (the file is a socket); use ``'socket`` to test for this file type
* ``c`` (the file is a character device); use ``'character`` to test for this file type
* ``b`` (the file is a block device); use ``'block`` to test for this file type
* ``D`` (the file is a door); use ``'door`` to test for this file type

For example:

.. code-block:: ruby

   its('type') { should eq 'file' }

or:

.. code-block:: ruby

   its('type') { should eq 'socket' }
