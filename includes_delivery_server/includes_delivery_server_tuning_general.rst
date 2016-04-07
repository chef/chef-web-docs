.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following settings are typically added to the server configuration file, including:

* Logging directories
* Maximum file sizes at which log rotation occurs
* The number of log files to keep

These values have the same default across all |delivery| services, but individual services can have their values overwritten. Add the service-specific values to the ``delivery.rb`` file. The list of services delivery starts which include logging can be determined by looking in the ``node['delivery']['log_directory']`` directory.

``<service_name>['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``/var/log/delivery/<service_name>``.

``<service_name>['log_rotation']['file_maxbytes']``
   |log_rotation| Default value: ``100 * 1024 * 1024`` (100MB).

``<service_name>['log_rotation']['num_to_keep']``
   |log_rotation| Default value: ``10``.
