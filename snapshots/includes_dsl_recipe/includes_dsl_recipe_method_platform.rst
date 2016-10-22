.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``platform?`` method to ensure that certain actions are run for specific platform. The ``platform?`` method will return true if one of the listed parameters matches the ``node['platform']`` attribute that is detected by Ohai during every chef-client run.

The syntax for the ``platform?`` method is as follows:

.. code-block:: ruby

   platform?('parameter', 'parameter')

where:

* ``parameter`` is a comma-separated list, each specifying a platform, such as Red Hat, CentOS, or Fedora
* ``platform?`` method is typically used with an ``if``, ``elseif``, or ``case`` statement that contains Ruby code that is specific for the platform, if detected


.. future example: step_resource_ruby_block_if_statement_use_with_platform
.. future example: step_resource_ruby_block_run_specific_blocks_on_specific_platforms
