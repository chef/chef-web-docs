=====================================================
Release Notes: chef-client 12.11
=====================================================

.. tag chef

Chef is a powerful automation platform that transforms infrastructure into code. Whether you’re operating in the cloud, on-premises, or in a hybrid environment, Chef automates how infrastructure is configured, deployed, and managed across your network, no matter its size.

This diagram shows how you develop, test, and deploy your Chef code.

.. image:: ../../images/start_chef.svg
   :width: 700px
   :align: center

.. end_tag

What's New
=====================================================
The following items are new for chef-client 12.11 and/or are changes from previous versions. The short version:

* **Support for standard exit codes in Chef client** Standard exit codes are now used by Chef client and should be identical across all OS platforms. New configuration setting ``exit_status`` has been added to specify how Chef client reports non-standard exit codes. 
* **New data collector functionality for run statistics** New feature that provides a unified method for sharing statistics about your Chef runs in webhook-like manner.
* **Default chef-solo behavior is equivalent to chef-client local mode** chef-solo now uses chef-client local mode. To use the previous ``chef-solo`` behavior, run in ``chef-solo --legacy-mode``.
* **New systemd_unit resource** Use the **systemd_unit** to manage systemd units.

exit_status
-----------------------------------------------------
When set to ``:enabled``, chef-client will use |url exit codes| for Chef client run status, and any non-standard exit codes will be converted to ``1`` or ``GENERIC_FAILURE``. This setting can also be set to ``:disabled`` which preserves the old behavior of using non-standardized exit codes and skips the deprecation warnings. Default value: ``nil``.

   .. note:: The behavior with the default value consists of a warning on the use of deprecated and non-standard exit codes. In a future release of Chef client, using standardized exit codes will be the default behavior.

Data collector
-----------------------------------------------------
The data collector feature is new to Chef 12.11. It provides a unified method for sharing statistics about your Chef runs in a webhook-like manner. The data collector supports Chef in all its modes: Chef client, Chef solo (commonly referred to as "Chef client local mode"), and Chef solo legacy mode.

To enable the data collector, specify the following settings in your client configuration file:

* ``data_collector.server_url``: Required. The URL to which the Chef client will POST the data collector messages
* ``data_collector.token``: Optional. An token which will be sent in a x-data-collector-token HTTP header which can be used to authenticate the message.
* ``data_collector.mode``: The Chef mode in which the data collector should run. Chef client mode is chef client configured to use Chef server to provide Chef client its resources and artifacts. Chef solo mode is Chef client configured to use a local Chef zero server (``chef-client --local-mode``). This setting also allows you to only enable data collector in Chef solo mode but not Chef client mode. Available options are ``:solo``, ``:client``, or ``:both``. Default is ``:both``.
* ``data_collector.raise_on_failure``: If enabled, Chef will raise an exception and fail to run if the data collector cannot be reached at the start of the Chef run. Defaults to false.
* ``data_collector.organization``: Optional. In Chef solo mode, the organization field in the messages will be set to this value. Default is ``chef_solo``. This field does not apply to Chef client mode.

Replace previous Chef-solo behavior with Chef client local mode
----------------------------------------------------------------
The default operation of chef-solo is now the equivalent to ``chef-client -z`` or ``chef-client --local-mode``, but you can use the previous chef-solo behavior by running in ``chef-solo --legacy-mode``. 
As part of this change, environment and role files written in ruby are now fully supported by ``knife upload``.

systemd_unit
------------------------------------------------------
Use the **systemd_unit** resource to create, manage, and run `systemd units <https://www.freedesktop.org/software/systemd/man/systemd.html#Concepts>`_.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_systemd_unit_syntax

A **systemd_unit** resource describes the configuration behavior for systemd units. For example:

.. code-block:: ruby

   systemd_unit 'sysstat-collect.timer' do
     enabled true
     content '[Unit]\nDescription=Run system activity accounting tool every 10 minutes\n\n[Timer]\nOnCalendar=*:00/10\n\n[Install]\nWantedBy=sysstat.service'
   end

The full syntax for all of the properties that are available to the **systemd_unit** resource is:

.. code-block:: ruby

   systemd_unit 'name' do
     enabled                Boolean
     active                 Boolean
     masked                 Boolean
     static                 Boolean
     user                   String
     content                String or Hash
     triggers_reload        Boolean
   end

where

* ``name`` is the name of the unit 
* ``active`` specifies if the service unit type should be started
* ``user`` is the user account that systemd units run under. If not specified, systemd units will run under the system account.
* ``content`` describes the behavior of the unit

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_systemd_unit_actions

This resource has the following actions:

``:create``
   Create a unit file, if it does not already exist.

``:delete``
   Delete a unit file, if it exists.

``:enable``
   Ensure the unit will be started after the next system boot.

``:disable``
   Ensure the unit will not be started after the next system boot.

``:nothing``
   Default. Do nothing with the unit.

``:mask``
   Ensure the unit will not start, even to satisfy dependencies.

``:unmask``
   Stop the unit from being masked and cause it to start as specified.

``:start``
   Start a unit based in its systemd unit file.

``:stop``
   Stop a running unit.

``:restart``
   Restart a unit.

``:reload``
   Reload the configuration file for a unit.

``:try_restart``
   Try to restart a unit if the unit is running.

``:reload_or_restart``
   For units that are services, this action reloads the configuration of the service without restarting, if possible; otherwise, it will restart the service so the new configuration is applied.

``:reload_or_try_restart``
   For units that are services, this action reloads the configuration of the service without restarting, if possible; otherwise, it will try to restart the service so the new configuration is applied.

.. end_tag

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_systemd_unit_attributes

This resource has the following properties:

``enabled``
   **Ruby Types:** TrueClass, FalseClass

   Specifies whether the unit is enabled or disabled.

``active``
   **Ruby Type:** TrueClass, FalseClass

   Specifies whether the unit is started or stopped.

``masked``
   **Ruby Type:** TrueClass, FalseClass

   Specifies whether the unit is masked or not.

``static``
   **Ruby Type:** TrueClass, FalseClass

   Specifies whether the unit is static or not. Static units cannot be enabled or disabled.

``user``
   **Ruby Type:** String

   The user account that the systemd unit process is run under. The path to the unit for that user would be something like 
   ``/etc/systemd/user/sshd.service``. If no user account is specified, the systemd unit will run under a ``system`` account, with the path to the unit being something like ``/etc/systemd/system/sshd.service``.

``content``
   **Ruby Type:** String, Hash

   A string or hash that contains a systemd `unit file <https://www.freedesktop.org/software/systemd/man/systemd.unit.html>`_ definition that describes the properties of systemd-managed entities, such as services, sockets, devices, and so on.

``triggers_reload``
   **Ruby Type:** TrueClass, FalseClass

   Specifies whether to trigger a daemon reload when creating or deleting a unit. Default is true.

.. end_tag

Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
