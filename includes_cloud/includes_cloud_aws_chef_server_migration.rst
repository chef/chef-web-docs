.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The process of migrating from an existing |chef server| installation to the |amazon ami| differs depending on which software version being used currently and the location in which it is deployed. In all on-premises scenarios, data is first migrated to the latest |chef server| schema, after which it is migrated to the |amazon ami|.

* Verify that the latest version of the |chef server| is installed by using the platform package manager: ``rpm -qa | grep chef-server-core`` and compare the result to the latest version available on the `downloads site <https://www.downloads.chef.io>`__. If this is not the latest version, download the package, and then `upgrade <https://docs.chef.io/upgrade_server.html#from-chef-server-title-12>`__ to the latest version.
* Upgrade an |chef server oec| node to the latest version of the |chef server| by following the `upgrade instructions <https://docs.chef.io/upgrade_server.html#from-chef-server-oec>`__.
* Upgrade an |chef server osc| node to the latest version of the |chef server| by following the `upgrade instructions <https://docs.chef.io/upgrade_server.html#from-chef-server-osc>`__.
