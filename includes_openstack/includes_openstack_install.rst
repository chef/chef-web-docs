.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Having reviewed the architecture and deployment prerequisites, you should be ready to install |openstack chef|.

* Be sure to read and understand the prerequisites for installation
* Check out the |openstack chef_repo| from |github|
* Follow the |berkshelf| instructions to download all of the appropriate cookbooks
* Edit the environment that will be used
* Converge the nodes, controller first, then compute
* Log in to the |openstack horizon| dashboard and either install or download the private key
* Create a test node

An installation that uses |chef provisioning| is located `here <https://github.com/openstack/openstack-chef-repo>`_; the ``README.md`` file describes the setup.
