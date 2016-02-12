.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``setup`` argument to set up authorization for a |google compute engine| account. If the ``-f`` parameter is used to override the default credential file, it will also need to be used with all subcommands. Be sure to specify the project identifier (and not its name or number) to prevent 404 errors (even if the ``knife google setup`` command runs successfully).