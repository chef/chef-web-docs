.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings:

``lb['api_fqdn']``
   Default value: ``node['fqdn']``.

``lb['cache_cookbook_files']``
   Default value: ``false``.

``lb['debug']``
   Default value: ``false``.

``lb['enable']``
   Default value: ``true``.

``lb['web_ui_fqdn']``
   Default value: ``node['fqdn']``.

``lb['vip']``
   The virtual IP address. Default value: ``127.0.0.1``.

``lb['upstream']['bookshelf']``
   Default value: ``127.0.0.1``.

``lb['upstream']['chef_server_webui']``
   Default value: ``127.0.0.1``.

``lb['upstream']['erchef']``
   Default value: ``127.0.0.1``.
