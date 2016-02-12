.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Always use ``mixlib-shellout`` to shell out. Never use backticks, Process.spawn, popen4, or anything else!

As of |chef client| version 12 you can use ``shell_out``, ``shell_out!`` and ``shell_out_with_system_locale`` directly in |dsl recipe|.
