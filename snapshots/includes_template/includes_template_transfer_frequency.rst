.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The chef-client caches a template when it is first requested. On each subsequent request for that template, the chef-client compares that request to the template located on the Chef server. If the templates are the same, no transfer occurs.
