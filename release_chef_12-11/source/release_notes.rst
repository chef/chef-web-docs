=====================================================
Release Notes: |chef client| 12.11
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for |chef client| 12.11 and/or are changes from previous versions. The short version:

* **Support for standard exit codes in Chef Client** Standard exit codes are now used by Chef Client and should be identical across all OS platforms. New configuration setting ``exit_status`` has been added to specify how Chef Client reports non-standard exit codes. 
* **New Data Collector functionality for run statistics** New feature that provides a unified method for sharing statistics about your Chef runs in webhook-like manner.
* **Default chef-solo behavior is equivalent to chef-client local mode** chef-solo now uses chef-client local mode. To use the previous ``chef-solo`` behavior, run in ``chef-solo --legacy-mode``.
* **New systemd_unit resource** Use the |resource systemd_unit| to manage systemd units.



exit_status
-----------------------------------------------------
|exit status| Default value: ``nil``.

   .. note:: The behavior with the default value consists of a warning on the use of deprecated and non-standard exit codes. In a future release of Chef client, using standardized exit codes will be the default behavior.


Data collector
-----------------------------------------------------
The data collector feature is new to Chef 12.11 and is detailed in Chef RFC 077. It provides a unified method for sharing statistics about your Chef runs in a webhook-like manner. The data collector supports Chef in all its modes: Chef Client, Chef Solo (commonly referred to as "Chef Client Local Mode"), and Chef Solo legacy mode.

To enable the data collector, specify the following settings in your client configuration file:

* ``data_collector.server_url``: Required. The URL to which the Chef Client will POST the Data Collector messages
* ``data_collector.token``: Optional. An token which will be sent in a x-data-collector-token HTTP header which can be used to authenticate the message.
* ``data_collector.mode``: The Chef mode in which the Data Collector should run. For example, this allows you to only enable Data Collector in Chef Solo but not Chef Client. Available options are :solo, :client, or :both. Default is :both.
* ``data_collector.raise_on_failure``: If enabled, Chef will raise an exception and fail to run if the Data Collector cannot be reached at the start of the Chef run. Defaults to false.
* ``data_collector.organization``: Optional. In Solo mode, the organization field in the messages will be set to this value. Default is chef_solo. This field does not apply to Chef Client mode.

Replace previous Chef-solo behavior with Chef Client local mode
----------------------------------------------------------------
The default operation of chef-solo is now the equivalent to ``chef-client -z`` or ``chef-client --local-mode``, but you can use the previous chef-solo behavior by running in ``chef-solo --legacy-mode``. 
As part of this change, environment and role files written in ruby are now fully supported by ``knife upload``.

systemd_unit
------------------------------------------------------
.. include:: ../../includes_resources/includes_resource_systemd_unit.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_systemd_unit_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_systemd_unit_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_systemd_unit_attributes.rst


Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
