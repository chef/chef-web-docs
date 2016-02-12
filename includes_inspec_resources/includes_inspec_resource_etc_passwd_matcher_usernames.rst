.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``usernames`` matcher tests if the usernames in the test match usernames in ``/etc/passwd``:

.. code-block:: ruby

   its('usernames') { should eq ['root', 'www-data'] }
