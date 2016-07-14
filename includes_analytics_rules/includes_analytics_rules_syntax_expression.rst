.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


An expression defines a specific test in a rule and uses fields within the expression that are specific to the message type for the rule. For example:

.. code-block:: ruby

   total_resource_count > 1 and
   updated_resource_count > 0

.. code-block:: ruby

   array:contains(run_list, 'role[opscode-reporting]')

where both ``total_resource_count``, ``updated_resource_count``, and ``run_list`` are the `fields specific to a message type <https://docs.chef.io/analytics_rules.html#message-types>`_.
