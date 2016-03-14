.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


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
