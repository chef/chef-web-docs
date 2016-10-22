.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``jetty``:

``jetty['enable']``
   Enable a service. Default value: ``'false'``. This value should not be modified.

``jetty['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``'false'``.

``jetty['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value:

   .. code-block:: ruby

      '/var/opt/opscode/opscode-solr4/jetty/logs'
