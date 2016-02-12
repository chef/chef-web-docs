.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``include?`` method can be used to ensure that a specific parameter is included before an action is taken. For example, using the ``include?`` method to find a specific parameter:

.. code-block:: ruby

   if ['debian', 'ubuntu'].include?(node['platform'])
     # do debian/ubuntu things
   end

or:

.. code-block:: ruby

   if %w{rhel}.include?(node['platform_family'])
     # do RHEL things
   end

