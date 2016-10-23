=====================================================
knife status 
=====================================================

.. include:: ../../includes_knife/includes_knife_status.rst

Syntax
=====================================================
.. include:: ../../includes_knife/includes_knife_status_syntax.rst

Options
=====================================================
.. note:: .. include:: ../../includes_knife/includes_knife_common_see_common_options_link.rst

This subcommand has the following options:

``QUERY``
   The search query used to identify a list of items on a Chef server. This option uses the same syntax as the ``search`` subcommand.

``-H``, ``--hide-healthy``
   Hide nodes on which a chef-client run has occurred within the previous hour.

``-l``, ``--long``
   Display all attributes in the output and show the output as JSON.

``-m``, ``--medium``
   Display normal attributes in the output and to show the output as JSON.

``-r RUN_LIST``, ``--run-list RUN_LIST``
   A comma-separated list of roles and/or recipes to be applied.

``-s``, ``--sort-reverse``
   Sort a list by last run time, descending.

.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
=====================================================
The following examples show how to use this knife subcommand:

**View status, include run-lists**

.. include:: ../../step_knife/step_knife_status_include_run_lists.rst

**View status using a date range**

.. include:: ../../step_knife/step_knife_status_past_hour.rst

**View status using a query**

.. include:: ../../step_knife/step_knife_status_returned_by_query.rst

**View status for all nodes**

.. include:: ../../step_knife/step_knife_status_view_for_all_nodes.rst
