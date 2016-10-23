.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


chef-solo may be run as a non-root user. For example, the ``sudoers`` file can be updated similar to:

.. code-block:: ruby

   # chef-solo privilege specification
   chef ALL=(ALL) NOPASSWD: /usr/bin/chef-solo

where ``chef`` is the name of the non-root user. This would allow chef-solo to run any command on the node without requiring a password.
