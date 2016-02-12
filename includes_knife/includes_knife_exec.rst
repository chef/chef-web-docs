.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |subcommand knife exec| subcommand uses the |knife| configuration file to execute |ruby| scripts in the context of a fully configured |chef client|. Use this subcommand to run scripts that will only access |chef server| one time (or otherwise very infrequently) or any time that an operation does not warrant full usage of the |knife| subcommand library.
