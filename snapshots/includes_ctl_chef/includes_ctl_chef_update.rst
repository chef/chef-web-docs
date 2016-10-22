.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``chef update`` subcommand to read the Policyfile.rb file, and then apply any changes. This will resolve dependencies and will create a Policyfile.lock.json file. The locked policy will reflect any changes to the run-list and will pull in any cookbook updates that are compatible with any version constraints defined in the Policyfile.rb file.
