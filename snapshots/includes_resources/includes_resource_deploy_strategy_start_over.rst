.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The chef-client uses a cache file to keep track of the order in which each revision of an application is deployed. By default, the cache file is located at ``/var/chef/cache/revision-deploys/APPNAME/``. To force a re-deploy, delete the deployment directory or delete the cache file.
