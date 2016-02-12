=====================================================
About Policy
=====================================================

.. include:: ../../includes_chef/includes_chef_policy.rst

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Policy Type
     - Description
   * - :doc:`Data Bags </data_bags>`
     - .. include:: ../../includes_data_bag/includes_data_bag.rst
   * - :doc:`Environments </environments>`
     - .. include:: ../../includes_environment/includes_environment.rst
   * - :doc:`Roles </roles>`
     - .. include:: ../../includes_role/includes_role.rst

Policyfile
=====================================================
.. warning:: Policy is a new (and experimental) feature released in the the |chef dk|. Policy will make improvements to how the code that is used to manage your infrastructure is authored, tested, and distributed. Policy is configured using a policy file. Some aspects of the design have not yet been finalized. If you are new to |chef|, please don't use it. If you are an experienced user, please try it out and provide feedback. If you do use it, please do so in a location that is isolated from production code.

Policy defines the cookbook revisions, environments, and roles that should be applied by the |chef client|.

For more information about policy and the configuration file used to manage and maintain policy---policyfile.rb---please see this topic on Github: https://github.com/chef/chef-dk/blob/master/POLICYFILE_README.md.
