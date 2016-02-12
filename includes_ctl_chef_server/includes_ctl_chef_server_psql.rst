.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``psql`` subcommand is used to log into the |postgresql| database associated with the named service. This subcommand:

* Uses ``psql`` (the interactive terminal for |postgresql|)
* Has read-only access by default
* Is the recommended way to interact with any |postgresql| database that is part of the |chef server|
* Automatically handles authentication
