.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

For services started using |systemd| (the |unix systemv|-compatible init system by the recent versions of |fedora| and other distributions), their environment can be altered using the ``Environment`` or ``EnvironmentFile`` options:

.. code-block:: ruby

   Environment="IMPORTANT_VAR='value'"

If the init script provided by the package does not include the necessary environment variables, you can manage your altered init script using the |resource template| resource.
