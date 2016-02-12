.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


.. note:: The following changes were made to the |subcommand knife search| subcommand, starting with the 11.0.0 version of the |chef client|:

   * |subcommand knife search| will assume node search when the object type is omitted
   * |subcommand knife search| will search over roles, tags, |fqdn| and/or IP addresses when the given query is not in |apache solr| format, i.e. "does not contain a colon (``:``) character"

