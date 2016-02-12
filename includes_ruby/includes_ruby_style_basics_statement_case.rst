.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``case`` statement can be used to handle a situation where there are a lot of conditions. Use the ``when`` statement for each condition, as many as are required.

For example, using a ``case`` statement with the ``platform`` node attribute:

.. code-block:: ruby

   case node['platform']
   when 'debian', 'ubuntu'
     # do debian/ubuntu things
   when 'redhat', 'centos', 'fedora'
     # do redhat/centos/fedora things
   end

For example, using a ``case`` statement with the ``platform_family`` node attribute:

.. code-block:: ruby

   case node['platform_family']
   when 'debian'
     # do things on debian-ish platforms (debian, ubuntu, linuxmint)
   when 'rhel'
     # do things on RHEL platforms (redhat, centos, scientific, etc)
   end


.. future example: step_resource_package_install_package_on_platform
.. future example: step_resource_package_use_case_statement
.. future example: step_resource_service_manage_ssh_based_on_node_platform

