.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``run_status`` object is initialized by the chef-client before the ``report`` interface is run for any handler. The ``run_status`` object keeps track of the status of the chef-client run and will contain some (or all) of the following properties:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Property
     - Description
   * - ``all_resources``
     - A list of all resources that are included in the ``resource_collection`` property for the current chef-client run.
   * - ``backtrace``
     - A backtrace associated with the uncaught exception data that caused a chef-client run to fail, if present; ``nil`` for a successful chef-client run.
   * - ``elapsed_time``
     - The amount of time between the start (``start_time``) and end (``end_time``) of a chef-client run.
   * - ``end_time``
     - The time at which a chef-client run ended.
   * - ``exception``
     - The uncaught exception data which caused a chef-client run to fail; ``nil`` for a successful chef-client run.
   * - ``failed?``
     - Show that a chef-client run has failed when uncaught exceptions were raised during a chef-client run. An exception handler runs when the ``failed?`` indicator is ``true``.
   * - ``node``
     - The node on which the chef-client run occurred.
   * - ``run_context``
     - An instance of the ``Chef::RunContext`` object; used by the chef-client to track the context of the run; provides access to the ``cookbook_collection``, ``resource_collection``, and ``definitions`` properties.
   * - ``start_time``
     - The time at which a chef-client run started.
   * - ``success?``
     - Show that a chef-client run succeeded when uncaught exceptions were not raised during a chef-client run. A report handler runs when the ``success?`` indicator is ``true``.
   * - ``updated_resources``
     - A list of resources that were marked as updated as a result of the chef-client run.

.. note:: These properties are not always available. For example, a start handler runs at the beginning of the chef-client run, which means that properties like ``end_time`` and ``elapsed_time`` are still unknown and will be unavailable to the ``run_status`` object.
