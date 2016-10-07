.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``provides`` method to associate a custom resource with the |dsl recipe| on different operating systems. When multiple custom resources use the same DSL, specificity rules are applied to determine the priority, from highest to lowest:

#. provides :resource_name, platform_version: ‘0.1.2’
#. provides :resource_name, platform: ‘platform_name’
#. provides :resource_name, platform_family: ‘platform_family’
#. provides :resource_name, os: ‘operating_system’
#. provides :resource_name

For example:

.. code-block:: ruby

    provides :my_custom_resource

    provides :my_custom_resource, os: 'linux'

    provides :my_custom_resource, platform: 'fedora'

    provides :my_custom_resource, platform_family: 'rhel'

    provides :my_custom_resource, platform_family: 'suse' do |node|
      node['platform_version'].to_i >= 13
    end

This allows you to use multiple custom resources files that provide the same resource to the user, but for different operating systems or operation system versions. With this you can eliminate the need for platform or platform version logic within your resources.
