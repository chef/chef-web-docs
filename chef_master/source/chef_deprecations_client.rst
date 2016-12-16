=====================================================
Chef Deprecation Warnings
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/chef_deprecations_client.rst>`__

When we wish to remove a feature or an API in Chef, we try to first mark it with a deprecation warning that contains a link to a description of the change and how to fix it. For example:

.. code-block:: ruby

   Deprecated features used!
     JSON auto inflation is not supported (CHEF-1) at (irb):7:in `irb_binding'.
     Please see https://docs.chef.io/chef-client/deprecations/json_auto_inflate.html for further details and information on how to correct this problem.

Testing for Deprecations
=====================================================

To test your code for deprecations, you can put Test Kitchen in a mode where any deprecations cause the chef run to fail. Ensure your ``.kitchen.yml`` includes:

.. code-block:: yaml

   provisioner:
     deprecations_as_errors: true

and then run Test Kitchen as usual. Test Kitchen will fail if any deprecation errors are issued. This feature was added in Test Kitchen 1.13, which shipped in ChefDK 1.0.

All Deprecations
=====================================================

.. list-table::
  :widths: 50 230 40 80
  :header-rows: 1

  * - ID
    - Description
    - Deprecated
    - Expected Removal
  * - :doc:`CHEF-0 </deprecations_internal_api>`
    - Many internal APIs have been improved.
    - various
    - varies
  * - :doc:`CHEF-1 </deprecations_json_auto_inflate>`
    - Consumers of JSON are now required to be explicit in how it is turned in to a Chef object.
    - 12.7.2
    - 13.0
  * - :doc:`CHEF-2 </deprecations_exit_code>`
    - Chef's exit codes are now defined so that it's easy to understand why Chef exited.
    - 12.11.4
    - 13.0
  * - :doc:`CHEF-3 </deprecations_chef_gem_compile_time>`
    - When using the ``chef_gem`` resource, the phase to install the gem in must be specified.
    - 12.1.0
    - 13.0
  * - :doc:`CHEF-4 </deprecations_attributes>`
    - Various improvements have been made to attribute syntax.
    - various
    - varies
  * - :doc:`CHEF-5 </deprecations_custom_resource_cleanups>`
    - Various improvements have been made to custom resource syntax.
    - various
    - varies
  * - :doc:`CHEF-6 </deprecations_easy_install>`
    - The ``easy_install`` resource will be removed.
    - 12.10.17
    - 13.0
  * - :doc:`CHEF-7 </deprecations_verify_file>`
    - The ``verify`` metaproperty's ``file`` substitution will be removed.
    - 12.5.1
    - 13.0
  * - :doc:`CHEF-8 </deprecations_supports_property>`
    - The ``supports`` metaproperty will be removed.
    - 12.14.17
    - 13.0
  * - :doc:`CHEF-9 </deprecations_chef_rest>`
    - The ``Chef::REST`` API will be removed.
    - 12.7.2
    - 13.0
  * - :doc:`CHEF-13 </deprecations_chef_platform_methods>`
    - Deprecated ``Chef::Platform`` methods
    - 12.18.x
    - 13.0
  * - :doc:`CHEF-3694 </deprecations_resource_cloning>`
    - Resource Cloning will no longer work.
    - 10.18.0
    - 13.0
