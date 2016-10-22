.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example will delete the ``/tmp/file`` symbolic link and uses the ``only_if`` guard to run the ``test -L`` command, which verifies that ``/tmp/file`` is a symbolic link, and then only deletes ``/tmp/file`` if the test passes:

.. code-block:: ruby

   link '/tmp/file' do
     action :delete
     only_if 'test -L /tmp/file'
   end
