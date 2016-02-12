.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``shell_out!`` method can be used to run a command against the node, display the output to the console when the log level is set to ``debug``, and then raise an error when the method returns ``false``.

The syntax for the ``shell_out!`` method is as follows:

.. code-block:: ruby

   shell_out!(command_args)

where ``command_args`` is the command that is run against the node. This method will return ``true`` or ``false``.
