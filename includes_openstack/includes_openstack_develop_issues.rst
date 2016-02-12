.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Bugs that are found in cookbooks should be tracked and managed using |launchpad|.

* View the main project: https://launchpad.net/openstack-chef
* View the list of open bugs: https://bugs.launchpad.net/openstack-chef
* File a new bug: https://bugs.launchpad.net/openstack-chef/+filebug

Use these guidelines when filing a bug:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Setting
     - Description
   * - Summary
     - A bug summary should be similar to ``[cookbook] short description of the issue`` where ``[cookbook]`` is the short name of the cookbook, and the short description is a one sentence description of the issue.
   * - Status
     - This setting should be left alone and remain ``New`` until someone has triaged the issue.
   * - Importance
     - Optional. This setting should only be modified when an issue is a blocker or a gating issue. In those situations, please set ``Importance`` to ``High``. Only use ``Critical`` for serious bugs, such as those that could take down entire infrastructures.
   * - Tags
     - Optional. Use tags to help group an issue. Tags should be high level and may be auto-completed.

Also:

* When adding an attribute, please specify the code location in which the base |openstack| attribute can be found, the configuration file, the section it goes into, and any changes to the default value for |chef|
* When fixing a converge exception, please provide the log information that contains the exception
* When adding functionality, please provide a brief example of a real world use case
* When an issue is platform-specific, please note that and provide any platform reference links that help explain why it's needed
* When fixing logic, please provide a good before/after description of the logic changes
* When adding driver or mechanism support, please provide reference links for the driver and/or mechanism
* When fixing unit or integration tests, please provide a general summary
* When bumping |rubygems| or cookbook versions, please explain why it needed

Issues with the |subcommand knife openstack| plugin are tracked using the |company_name| github issue tracking system: https://github.com/chef/knife-openstack/issues.
