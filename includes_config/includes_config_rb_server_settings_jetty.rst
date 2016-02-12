.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``jetty``:

``jetty['enable']``
   |enable service| Default value: ``'false'``. This value should not be modified.

``jetty['ha']``
   |use ha| |ha true| Default value: ``'false'``.

``jetty['log_directory']``
   |directory logs| |default_value_recommended| Default value:

   .. code-block:: ruby

      '/var/opt/opscode/opscode-solr4/jetty/logs'
