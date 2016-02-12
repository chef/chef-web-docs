.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following settings are typically added to the |analytics rb| file:

``actions_consumer['hipchat_api_token']``
   An hipchat v2 API token for your hipchat account that will be used for publishing notifications.

``actions_consumer['hipchat_enabled']``
   A list of organizations for which hipchat notifications will be published.

``actions_consumer['hipchat_room']``
   The hipchat room to which notifications will be published.

``analytics_fqdn``
   The |fqdn| for the |chef analytics| server. This setting is not in the |analytics rb| file by default. When added, its value should be equal to the |fqdn| for the service URI used by the |chef analytics| server. If you are installing in combined mode (|chef server oec| and |chef analytics| servers on the same node) then this must be different from the |fqdn| for the |chef server oec| server.

``data_retention['month_interval_to_keep_activities']``
   The number of months for which activities data is retained. Default value: ``3``.

``data_retention['keep_all_data']``
   Use to specify if all events are kept. If this setting is ``true``, the ``month_interval_to_keep_activities`` value is ignored. Default value: ``false``.

``nginx['ssl_protocols']``
   |version protocols_ssl| For the highest possible security, disable |ssl| 3.0 and allow only TLS: ``nginx['ssl_protocols'] 'TLSv1 TLSv1.1 TLSv1.2'``.

``notifier_config['accept_insecure']``
   Use to disable authentication to |api analytics| endpoints that create and modify rules and notifications. This setting should only be set to ``true`` when debugging rules and notifications in a non-production environment. Default value: ``false``.

``ssl['cacert_file_path']``
   Use to specify the path to the ``cacert.pem`` file. Default value: ``'/opt/opscode-analytics/embedded/ssl/certs/cacert.pem'``.

``ssl['certificate']``
   |ssl_certificate|

``ssl['certificate_key']``
   |ssl_certificate key|

``ssl['sslprotocols']``
   |version protocols_ssl| For the highest possible security, disable |ssl| 3.0 and allow only TLS: ``nginx['ssl_protocols'] 'TLSv1 TLSv1.1 TLSv1.2'``.

``topology``
   Default value: ``combined``.
