.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The naming patterns of custom resources and providers are determined by the name of the cookbook and by the name of the files in the ``resources/`` and ``providers/`` sub-directories. For example, if a cookbook named ``example`` was downloaded to the chef-repo, it would be located at ``/cookbooks/example/``. If that cookbook contained two resources and two providers, the following files would be part of the ``resources/`` directory:

.. list-table::
   :widths: 120 120 120
   :header-rows: 1

   * - Files
     - Resource Name
     - Generated Class
   * - ``default.rb``
     - example
     - Chef::Resource::Example
   * - ``custom.rb``
     - example_custom
     - Chef::Resource::ExampleCustom

And the following files would be part of the ``providers/`` directory:

.. list-table::
   :widths: 120 120 120
   :header-rows: 1

   * - Files
     - Provider Name
     - Generated Class
   * - ``default.rb``
     - example
     - Chef::Provider::Example
   * - ``custom.rb``
     - example_custom
     - Chef::Provider::ExampleCustom
