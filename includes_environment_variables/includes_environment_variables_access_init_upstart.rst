.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

For services started using |upstart| (the |unix systemv|-compatible init system used by recent versions of |ubuntu| and other distributions), their environment can be altered using ``env``:

.. code-block:: ruby

   env IMPORTANT_VAR='value'
