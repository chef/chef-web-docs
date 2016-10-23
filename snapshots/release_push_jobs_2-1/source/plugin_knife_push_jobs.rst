.. THIS PAGE DOCUMENTS Push Jobs version 2.1

=====================================================
knife push jobs
=====================================================

.. include:: ../../includes_plugin_knife/includes_plugin_knife_push_jobs.rst

.. note:: Review the list of `common options <https://docs.chef.io/knife_common_options.html>`_ available to this (and all) knife subcommands and plugins.

job list
=====================================================
.. include:: ../../includes_plugin_knife/includes_plugin_knife_push_jobs_job_list.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_push_jobs_job_list_syntax.rst

Options
-----------------------------------------------------
This command does not have any specific options.

job output
=====================================================
.. include:: ../../includes_plugin_knife/includes_plugin_knife_push_jobs_job_output.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_push_jobs_job_output_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_push_jobs_job_output_options.rst

Examples
-----------------------------------------------------

**View the STDOUT from my-node for job with ID 26e98ba162fa7ba6fb2793125553c7ae**

.. code-block:: bash

  $ knife job output --channel stdout 26e98ba162fa7ba6fb2793125553c7ae my-node


job start
=====================================================
.. include:: ../../includes_plugin_knife/includes_plugin_knife_push_jobs_job_start.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_push_jobs_job_start_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_push_jobs_job_start_options_2-1.rst

Examples
-----------------------------------------------------
**Run a job**

.. include:: ../../step_plugin_knife/step_plugin_knife_push_jobs_job_start_run_job.rst

**Run a job using quorum percentage**

.. include:: ../../step_plugin_knife/step_plugin_knife_push_jobs_job_start_search_by_quorum.rst

**Run a job using node names**

.. include:: ../../step_plugin_knife/step_plugin_knife_push_jobs_job_start_search_by_nodes.rst


job status
=====================================================
.. include:: ../../includes_plugin_knife/includes_plugin_knife_push_jobs_job_status.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_push_jobs_job_status_syntax.rst

Options
-----------------------------------------------------
This command does not have any specific options.

Examples
-----------------------------------------------------
**View job status by job identifier**

.. include:: ../../step_plugin_knife/step_plugin_knife_push_jobs_job_status_by_id.rst

node status
=====================================================
.. include:: ../../includes_plugin_knife/includes_plugin_knife_push_jobs_node_status.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_push_jobs_node_status_syntax.rst

Options
-----------------------------------------------------
This command does not have any specific options.
