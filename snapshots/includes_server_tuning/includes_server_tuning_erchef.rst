.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following settings are often modified from the default as part of the tuning effort for the **opscode-erchef** service:

``opscode_erchef['db_pool_size']``
   The number of open connections to PostgreSQL that are maintained by the service. If failures indicate that the **opscode-erchef** service ran out of connections, try increasing the ``postgresql['max_connections']`` setting. If failures persist, then increase this value (in small increments) and also increase the value for ``postgresql['max_connections']``. Default value: ``20``.

``opscode_erchef['s3_url_ttl']``
   The amount of time (in seconds) before connections to the server expire. If chef-client runs are timing out, increase this setting to ``3600``, and then adjust again if necessary. Default value: ``900``.

``opscode_erchef['strict_search_result_acls']``
   .. include:: ../../includes_settings/includes_settings_strict_search_result_acls.rst
