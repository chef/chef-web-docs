.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``be_pipe`` matcher tests if the file exists as first-in, first-out special file (``.fifo``) that is typically used to define a named pipe, such as ``/var/log/nginx/access.log.fifo``:

.. code-block:: ruby

   it { should be_pipe }
