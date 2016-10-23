.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Each individual ``rule`` must be associated with a specific message type. As a rule is triggered during the chef-client run, a message is sent to the Chef Analytics server. A rule may be configured to send notifications about a message to recipients that are located outside of the Chef Analytics server.

A message type must be one of the following:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Message Type
     - Description
   * - ``action``
     - Use to build rules for messages about actions that occur on the Chef server.
   * - ``run_control``
     - Use to build rules for a single audit to be evaluated.
   * - ``run_control_group``
     - Use to build rules for a group of audits to be evaluated.
   * - ``run_converge``
     - Use to build rules for messages that are sent at the end of a chef-client run.
   * - ``run_resource``
     - Use to build rules for messages that are sent as each resource is converged during a chef-client run.
   * - ``run_start``
     - Use to build rules for messages that are sent at the start of a chef-client run.
