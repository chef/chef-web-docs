.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``oc_chef_authz``:

``oc_chef_authz['http_cull_interval']``
   Default value: ``'{1, min}'``.

``oc_chef_authz['http_init_count']``
   Default value: ``25``.

``oc_chef_authz['http_max_age']``
   Default value: ``'{70, sec}'``.

``oc_chef_authz['http_max_connection_duration']``
   Default value: ``'{70, sec}'``.

``oc_chef_authz['http_max_count']``
   Default value: ``100``.

``oc_chef_authz['ibrowse_options']``
   The amount of time (in milliseconds) to wait for a connection to be established. Default value: ``'[{connect_timeout, 5000}]'``.
