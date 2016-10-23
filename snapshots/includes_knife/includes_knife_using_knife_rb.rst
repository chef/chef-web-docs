.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

In addition to the default settings in a knife.rb file, there are other subcommand-specific settings that can be added. When a subcommand is run, knife will use:

#. A value passed via the command-line
#. A value contained in the knife.rb file
#. The default value

A value passed via the command line will override a value in the knife.rb file; a value in a knife.rb file will override a default value.

