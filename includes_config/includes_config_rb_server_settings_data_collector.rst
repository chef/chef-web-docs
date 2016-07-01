.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``data_collector``:

``data_collector['root_url']``
   |data_collector_server_url| When present, it will enable the |data_collector| |service erchef| application.
``data_collector['token']``
   |data_collector_token|
``data_collector['timeout']``
   |timeout data_collector| Default value: `30000`.
``data_collector['http_init_count']``
   |data_collector_http_init_count| Default value: `25`.
``data_collector['http_max_count']``
   |data_collector_http_max_count| Default value: `100`.
``data_collector['http_max_age']``
   |data_collector_http_max_age| Default value: `"{70, sec}"`.
``data_collector['http_cull_interval']``
   |data_collector_http_cull_interval| Default value: `"{1, min}"`.
``data_collector['http_max_connection_duration']``
   |data_collector_http_max_connection_duration| Default value: `"{70, sec}"`.
``data_collector['ibrowse_options']``
   |data_collector_ibrowse_options| Default value: `"[{connect_timeout, 10000}]"`.
