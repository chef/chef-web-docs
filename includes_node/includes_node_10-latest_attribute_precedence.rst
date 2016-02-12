.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


.. warning:: Starting with the 11.0 version of the |chef client|, node attributes must specify attribute precedence. For example, instead of ``node[:my_attribute] = 'value'`` use ``node.normal[:my_attribute] = 'value'``, where ``normal`` is the attribute precedence level. (Even with this change, please take a moment to consider using default-level attributes instead. In general, normal-level attributes are only required when a value needs to persist across |chef client| runs (such as auto-generated passwords) or when a node is a "special snowflake".)

Attributes are always applied by the |chef client| in the following order:

#. A ``default`` attribute located in a cookbook attribute file
#. A ``default`` attribute located in a recipe
#. A ``default`` attribute located in an environment
#. A ``default`` attribute located in role
#. A ``normal`` attribute located in a cookbook attribute file
#. A ``normal`` attribute located in a recipe
#. An ``override`` attribute located in a cookbook attribute file
#. An ``override`` attribute located in a recipe
#. An ``override`` attribute located in a role
#. An ``override`` attribute located in an environment 
#. An ``automatic`` attribute identified by |ohai| at the start of the |chef client| run

where the last attribute in the list is the one that is applied to the node.

.. note:: The attribute precedence order for roles and environments is reversed for ``default`` and ``override`` attributes. The precedence order for ``default`` attributes is environment, then role. The precedence order for ``override`` attributes is role, then environment. Applying environment ``override`` attributes after role ``override`` attributes allows the same role to be used across multiple environments, yet ensuring that values can be set that are specific to each environment (when required). For example, the role for an application server may exist in all environments, yet one environment may use a database server that is different from other environments.

Attribute precedence, viewed from the same perspective as the overview diagram, where the numbers in the diagram match the order of attribute precedence:

.. image:: ../../images/overview_chef_10_attributes_precedence.png

Attribute precedence, when viewed as a table:

.. image:: ../../images/overview_chef_10_attributes_table.png


