.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for database configurations:

``supermarket['database']['extensions']``
   Default value: ``{ 'pgpsql' => true, 'pg_trgm' => 'true' }``.

``supermarket['database']['host']``
   Default value: ``node['supermarket']['postgresql']['listen_address']``.

``supermarket['database']['name']``
   Default value: ``'supermarket'``.

``supermarket['database']['pool']``
   Default value: ``node['supermarket']['sidekiq']['concurrency']``.

``supermarket['database']['port']``
   Default value: ``node['supermarket']['postgresql']['port']``.

``supermarket['database']['user']``
   Default value: ``node['supermarket']['postgresql']['username']``.
