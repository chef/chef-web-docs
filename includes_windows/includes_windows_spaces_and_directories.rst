.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Directories that are used by |chef| on the |windows| platform cannot have spaces. For example, ``/c/Users/Steven Danno`` will not work, but ``/c/Users/StevenDanno`` will.

A different issue exists with the |knife| command line tool that is also related to spaces and directories. The ``knife cookbook site install`` subcommand will fail when the |windows| directory contains a space.
