.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``value_for_platform_family`` method in a recipe to select a value based on the ``node['platform_family']`` attribute. This value is detected by Ohai during every chef-client run.

The syntax for the ``value_for_platform_family`` method is as follows:

.. code-block:: ruby

   value_for_platform_family( 'platform_family' => { 'version' => 'value' }, ... )

where:

* ``'platform_family' => { 'version' => 'value' }, ...`` is a comma-separated list of platforms, such as Fedora, openSUSE, or Red Hat Enterprise Linux
* ``value`` specifies the value that will be used if the node's platform family matches the ``value_for_platform_family`` method

When each value only has a single platform, use the following syntax:

.. code-block:: ruby

   value_for_platform_family(
     'platform_family' => { 'version' => 'value' },
     'platform_family' => { 'version' => 'value' },
     'platform_family' => 'value'
   )

When each value has more than one platform, the syntax changes to:

.. code-block:: ruby

   value_for_platform_family(
     ['platform_family', 'platform_family', 'platform_family', 'platform_family' ] => 'value',
     ['platform_family', 'platform_family'] => 'value',
     'default' => 'value'
   )

The following example will set ``package`` to ``httpd-devel`` for the Red Hat Enterprise Linux, Fedora, and openSUSE platforms and to ``apache2-dev`` for the Debian platform:

.. code-block:: ruby

   package = value_for_platform_family(
     ['rhel', 'fedora', 'suse'] => 'httpd-devel',
       'debian' => 'apache2-dev'
   )
