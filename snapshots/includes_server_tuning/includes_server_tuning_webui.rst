.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following setting is often modified from the default as part of the tuning effort for the **opscode-webui** service:

``opscode_webui['worker_processes']``
   The number of allowed worker processes. This setting should be increased or decreased based on the number of users in an organization who use the Chef server web user interface. The default value is ``2``.
