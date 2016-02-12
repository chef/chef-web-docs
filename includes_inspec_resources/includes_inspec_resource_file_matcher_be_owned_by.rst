.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``be_owned_by`` matcher tests if the file is owned by the named user, such as ``root``:

.. code-block:: ruby

   it { should be_owned_by 'root' }
