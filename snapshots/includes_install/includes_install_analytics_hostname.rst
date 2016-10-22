.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The hostname for the Chef Analytics server may be specified using a FQDN or an IP address. This hostname must be resolvable. For example, a Chef Analytics server that is running in a production environment with a resolvable FQDN hostname can be added in the DNS system. But when deploying Chef Analytics into a testing environment, adding the hostname to the ``/etc/hosts`` file is enough to ensure that hostname is resolvable.

* **FQDN Hostnames** When the hostname for the Chef Analytics server is a FQDN be sure to include the domain suffix. For example, something like ``myanalyticsserver.example.com`` (and not something like ``myanalyticsserver``).

The ``analytics_fqdn`` setting must be added to the opscode-analytics.rb file (it is not there by default). Its value should be equal to the FQDN or IP address for the service URI used by the Chef Analytics server. For example: ``analytics_fqdn "chef-analytics.example.com"`` or ``analytics_fqdn 123.45.67.890``.
