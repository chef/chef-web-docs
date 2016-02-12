=====================================================
|chef analytics_title| Rules
=====================================================

.. include:: ../../includes_analytics_rules/includes_analytics_rules.rst

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst

Rule Syntax
=====================================================
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax.rst

Message Types
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax_message_types.rst

when
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax_when.rst

Expressions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax_expression.rst

then
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax_then.rst

otherwise
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax_otherwise.rst

with priority
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax_priority.rst

Comments
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax_comments.rst

Whitespace
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax_whitespace.rst

Strings
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax_strings.rst

Numbers
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax_numbers.rst

Regular Expressions
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax_regex.rst

Nested Fields, Arrays
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax_nested.rst

Message Fields
=====================================================

The following sections describe the fields that may be used for each of
the specific message types.

actions
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax_expression_type_action.rst

run_control
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax_expression_type_run_control.rst

run_control_group
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax_expression_type_run_control_group.rst

run_converge
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax_expression_type_run_converge.rst

run_resource
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax_expression_type_run_resource.rst

run_start
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax_expression_type_run_start.rst

Functions
=====================================================
.. include:: ../../includes_analytics_rules/includes_analytics_rules_functions.rst

alert:<level>()
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_functions_audit.rst

array:contains()
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_functions_array.rst

datetime:component()
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_functions_datetime.rst

get()
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_functions_get.rst

log()
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_functions_log.rst

mustache_template()
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_functions_mustache.rst

notify()
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_functions_notify.rst

set()
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules_functions_set.rst

Examples
=====================================================
The following examples show how to define |chef analytics| rules.

Always Run a Rule
-----------------------------------------------------
.. include:: ../../step_analytics_rules/step_analytics_rules_types_always_run.rst

Raise Audit
-----------------------------------------------------
.. include:: ../../step_analytics_rules/step_analytics_rules_raise_audit.rst

.. _analytics_rules_send_a_notification:

Send a Notification
-----------------------------------------------------
.. include:: ../../step_analytics_rules/step_analytics_rules_send_a_notification.rst

Regular Expressions
-----------------------------------------------------
.. include:: ../../step_analytics_rules/step_analytics_rules_regular_expression.rst

Notify on Port 23
-----------------------------------------------------
.. include:: ../../step_analytics_rules/step_analytics_rules_listen_on_port.rst

User-defined Values
-----------------------------------------------------
.. include:: ../../step_analytics_rules/step_analytics_rules_user_defined_values.rst

Verify Dates
-----------------------------------------------------
.. include:: ../../step_analytics_rules/step_analytics_rules_verify_dates.rst

Verify Resource Updates
-----------------------------------------------------
.. include:: ../../step_analytics_rules/step_analytics_rules_verify_resource_updates.rst

Verify Run-lists
-----------------------------------------------------
.. include:: ../../step_analytics_rules/step_analytics_rules_verify_run_lists.rst