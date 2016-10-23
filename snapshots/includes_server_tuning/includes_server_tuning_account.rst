.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following setting is often modified from the default as part of the tuning effort for the **opscode-account** service:

``opscode_account['worker_processes']``
   The number of allowed worker processes. This value should be increased if requests made to the **opscode-account** service are timing out, but only if the front-end machines have available CPU and RAM. Default value: ``4``.

