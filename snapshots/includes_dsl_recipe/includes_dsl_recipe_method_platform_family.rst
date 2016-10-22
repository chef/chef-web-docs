.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``platform_family?`` method to ensure that certain actions are run for specific platform family. The ``platform_family?`` method will return true if one of the listed parameters matches the ``node['platform_family']`` attribute that is detected by Ohai during every chef-client run. 

The syntax for the ``platform_family?`` method is as follows:

.. code-block:: ruby

   platform_family?('parameter', 'parameter')

where:

* ``'parameter'`` is a comma-separated list, each specifying a platform family, such as Debian, or Red Hat Enterprise Linux
* ``platform_family?`` method is typically used with an ``if``, ``elseif``, or ``case`` statement that contains Ruby code that is specific for the platform family, if detected

For example:

.. code-block:: ruby

   if platform_family?('rhel')
     # do RHEL things
   end

or:

.. code-block:: ruby

   if platform_family?('debian', 'rhel')
     # do things on debian and rhel families
   end

.. future example: step_resource_remote_file_use_platform_family
