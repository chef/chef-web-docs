.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``estatsd``:

``estatsd['dir']``
   The working directory. The default value is the recommended value. Default value: ``'/var/opt/opscode/estatsd'``.

``estatsd['enable']``
   Enable a service. Default value: ``true``.

``estatsd['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``'/var/log/opscode/estatsd'``.

``estatsd['port']``
   The port on which the service is to listen. Default value: ``9466``.

``estatsd['protocol']``
   Use to send application statistics with StatsD protocol formatting. Set this value to ``statsd`` to apply StatsD protocol formatting.

``estatsd['vip']``
   The virtual IP address. Default value: ``'127.0.0.1'``.
