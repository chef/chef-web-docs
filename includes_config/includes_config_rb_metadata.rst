.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A |metadata rb| file is:

* Located at the top level of a cookbook's directory structure
* Compiled whenever a cookbook is uploaded to the |chef server| or when the ``knife cookbook metadata`` subcommand is run, and then stored as |json| data
* Created automatically by |knife| whenever the ``knife cookbook create`` subcommand is run
* Edited using a text editor, and then re-uploaded to the |chef server| as part of a cookbook upload
