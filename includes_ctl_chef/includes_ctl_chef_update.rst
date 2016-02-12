.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``chef update`` subcommand is used to read the |policyfile rb| file, and then apply any changes. This will resolve dependencies and will create a |policylock| file. The locked policy will reflect any changes to the run-list and will pull in any cookbook updates that are compatible with any version constraints defined in the |policyfile rb| file.
