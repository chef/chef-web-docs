.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``repos`` matcher tests if a named repo, using either a full identifier (``'updates/7/x86_64'``) or a short identifier (``'updates'``), is included in the |yum| repo:

.. code-block:: ruby

   its('repos') { should include 'some_repo' }
