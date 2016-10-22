.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``value_for_platform`` method in a recipe to select a value based on the ``node['platform']`` and ``node['platform_version']`` attributes. These values are detected by Ohai during every chef-client run.

The syntax for the ``value_for_platform`` method is as follows:

.. code-block:: ruby

   value_for_platform( ['platform', ...] => { 'version' => 'value' } )

where:

* ``'platform', ...`` is a comma-separated list of platforms, such as Red Hat, openSUSE, or Fedora
* ``version`` specifies the version of that platform
* Version constraints---``>``, ``<``, ``>=``, ``<=``, ``~>``---may be used with ``version``; an exception is raised if two version constraints match; an exact match will always take precedence over a match made from a version constraint
* ``value`` specifies the value that will be used if the node's platform matches the ``value_for_platform`` method

When each value only has a single platform, use the following syntax:

.. code-block:: ruby

   value_for_platform(
     'platform' => { 'version' => 'value' },
     'platform' => { 'version' => 'value' },
     'platform' => 'value'
   )

When each value has more than one platform, the syntax changes to:

.. code-block:: ruby

   value_for_platform(
     ['platform', 'platform', ... ] => {
       'version' => 'value'
     },
   )
