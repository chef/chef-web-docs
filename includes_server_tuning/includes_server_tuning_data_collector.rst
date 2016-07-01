.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following settings are often modified from the default as part of the tuning effort for the |service data_collector| |service erchef| application:

``data_collector['http_max_count']``
   |data_collector_http_max_count| If failures indicate that |service erchef| application has run out of HTTP connections for the |service data_collector| then increase this value. Default value: `100`.
