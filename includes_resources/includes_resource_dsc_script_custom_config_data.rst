.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Configuration data in |windows powershell_dsc_short| scripts may be customized from a recipe. For example, scripts are typically customized to set the behavior for |windows powershell| credential data types. Configuration data may be specified in one of three ways:

* By using the ``configuration_data`` attribute
* By using the ``configuration_data_script`` attribute
* By specifying the path to a valid |windows powershell| data file
