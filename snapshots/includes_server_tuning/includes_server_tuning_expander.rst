.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following setting is often modified from the default as part of the tuning effort for the **opscode-expander** service:

``opscode_expander['nodes']``
   The number of allowed worker processes. The **opscode-expander** service runs on the back-end and feeds data to the **opscode-solr** service, which creates and maintains search data used by the Chef server. Additional memory may be required by these worker processes depending on the frequency and volume of chef-client runs across the organization, but only if the back-end machines have available CPU and RAM. Default value: ``2``.

