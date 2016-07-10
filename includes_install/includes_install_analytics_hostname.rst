.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The hostname for the |chef analytics| server may be specified using a |fqdn| or an IP address. This hostname must be resolvable. For example, a |chef analytics| server that is running in a production environment with a resolvable |fqdn| hostname can be added in the |dns| system. But when deploying |chef analytics| into a testing environment, adding the hostname to the ``/etc/hosts`` file is enough to ensure that hostname is resolvable.

* **FQDN Hostnames** When the hostname for the |chef analytics| server is a |fqdn| be sure to include the domain suffix. For example, something like ``myanalyticsserver.example.com`` (and not something like ``myanalyticsserver``).

The ``analytics_fqdn`` setting must be added to the |analytics rb| file (it is not there by default). Its value should be equal to the |fqdn| or IP address for the service URI used by the |chef analytics| server. For example: ``analytics_fqdn "chef-analytics.example.com"`` or ``analytics_fqdn 123.45.67.890``.
