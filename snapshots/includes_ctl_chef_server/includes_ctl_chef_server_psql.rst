.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``psql`` subcommand is used to log into the PostgreSQL database associated with the named service. This subcommand:

* Uses ``psql`` (the interactive terminal for PostgreSQL)
* Has read-only access by default
* Is the recommended way to interact with any PostgreSQL database that is part of the Chef server
* Automatically handles authentication
