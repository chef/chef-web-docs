.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.



To set the system |ruby| for the |windows| platform `the steps described for all platforms are true <https://docs.chef.io/install_dk.html#set-the-system-ruby>`_, but then require the following manual edits to the ``chef shell-init bash`` output for the |windows| platform:

#. Add quotes around the variable assignment strings.
#. Convert ``C:/`` to ``/c/``.
#. Save those changes.
