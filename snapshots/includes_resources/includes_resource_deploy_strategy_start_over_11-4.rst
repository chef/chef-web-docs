.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The chef-client uses a cache file to keep track of the order in which each revision of an application is deployed. If a re-deployment must be forced---by deleting the deployed code from a node, for example---the cache file must be deleted as well. The cache file is located in the default configuration at ``/var/chef/cache/revision-deploys/APPNAME/``.
