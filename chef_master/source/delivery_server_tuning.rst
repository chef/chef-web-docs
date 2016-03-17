=====================================================
Delivery Server Tuning
=====================================================

|chef delivery| has several different levers you can pull to adjust logging settings, including:

* Logging directory
* Maximum file sizes at which to rotate
* Number of log files to keep

These values default across all delivery services, but individual services can have their values overwritten. Add these values to the ``delivery.rb`` file.

The list of services delivery starts which include logging can be determined by looking in the ``node['delivery']['log_directory']`` directory.

Logging Directory
=====================================================
Use the ``['delivery']['<service_name>']['log_directory']`` to specify the logging directory for the named service. Default value: ``/var/log/delivery/``.

Each service defaults to ``/var/log/delivery/<service_name>``.

Maximum File Sizes
=====================================================
Use the ``['delivery']['<service_name>']['log_rotation']['file_maxbytes']`` to specify the maximum file sizes, after which the log file will rotate. Default value: ``100MB`` for all services, except for the ``delivery`` service which defaults to ``10MB``.

Number of Log Files to Keep
=====================================================
Use the ``['delivery']['<service_name>']['log_rotation']['num_to_keep']`` to specify the number of log files to keep. Default value: ``10``.
