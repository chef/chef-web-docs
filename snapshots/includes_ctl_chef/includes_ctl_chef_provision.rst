.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``chef provision`` subcommand to invoke an embedded chef-client run to provision machines using Chef provisioning. By default, this subcommand expects to find a cookbook named ``provision`` in the current working directory. The chef-client run will run a recipe in this cookbook that uses Chef provisioning to create one (or more) machines.

The ``chef provision`` subcommand is intended to:

* Provide a provisioning mechamism that supports using Policyfile.rb files
* Supporting naming conventions within Chef provisioning
* Integreate Chef provisioning steps with the command-line tools that are packaged with the Chef development kit
* Separate the configuration of provisioned machines from running Chef provisioning
* Allow provisioing to be managed as code and versioned (via Policyfile.rb files), as opposed to the legacy ``knife bootstrap`` behavior, which is primarily driven by command-line options
