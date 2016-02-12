=====================================================
|policyfile rb|
=====================================================

.. warning:: This feature is new and experimental. Some aspects of the design have not yet been finalized. If you are new to |chef|, please don't use it. If you are an experienced user, please try it out and provide feedback. If you do use it, please do so in a location that is isolated from production code.

A policy file allows you to specify in a single document the cookbook revisions and recipes that should be applied by the |chef client|. A policy file is uploaded to the |chef server|, where it is associated with a group of nodes. When these nodes are configured by the |chef client|, the |chef client| will make decisions based on settings in the policy file, and will build a run-list based on that information. A policy file may be versioned, and then promoted through deployment stages to safely and reliably deploy new configuration. 

A policyfile is a |ruby| file, in which a run-list and cookbook locations are specified. The syntax is as follows:

.. code-block:: ruby

   name "name"
   run_list "ITEM", "ITEM", ...
   default_source :SOURCE_TYPE, *args
   cookbook "NAME" [, "VERSION_CONSTRAINT"] [, SOURCE_OPTIONS]

where:

* ``name`` is the name of the policy. Required. Use a name that reflects the purpose of the machines against which the policy will run.
* ``run_list`` is the run-list the |chef client| will use to apply the policy to one (or more) nodes. Required.
* ``default_source`` is the location in which cookbooks are located that are not specified by ``cookbook``; if all cookbooks are specified by ``cookbook``, this setting is not needed.
* ``cookbook`` is used to add cookbooks to the policy, specify a version constraint, or specify an alternate source location, such as |supermarket|.

For example:

.. code-block:: ruby

   name "jenkins-master"
   run_list "java", "jenkins::master", "recipe[policyfile_demo]"
   default_source :community
   cookbook "policyfile_demo", path: "cookbooks/policyfile_demo"
   cookbook "jenkins", "~> 2.1"
   cookbook "mysql", github: "chef-cookbooks/mysql", branch: "master"

For more information about policy and the configuration file used to manage and maintain policy---policyfile.rb---please see this topic on Github: https://github.com/chef/chef-dk/blob/master/POLICYFILE_README.md.