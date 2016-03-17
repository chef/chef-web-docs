.. THIS PAGE IS IDENTICAL TO docs.chef.io/policy.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /devkit/ PATH.

=====================================================
Policy
=====================================================

.. warning:: Policy is a new (and experimental) feature first released in the 0.3.0 version of the |chef dk|. Policy will make improvements to how the code that is used to manage your infrastructure is authored, tested, and distributed. Policy is configured using a policy file.

Policy defines the cookbook revisions, environments, and roles that should be applied by the |chef client|.

.. warning:: This feature is new and experimental. Some aspects of the design have not yet been finalized. If you are new to |chef|, please don't use it. If you are an experienced user, please try it out and provide feedback. If you do use it, please do so in a location that is isolated from production code.

For more information about policy and the configuration file used to manage and maintain policy---policyfile.rb---please see this topic on Github: https://gist.github.com/danielsdeleo/52c90c9e3c9c76b80316.