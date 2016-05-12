.. The contents of this file is sync'd with /release_compliance/index.rst

=====================================================
Welcome to Chef!
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

* The workstation is the location from which all of |chef| is managed, including :doc:`installing the Chef DK </install_dk>`, :doc:`authoring cookbooks </cookbooks>`, and using tools like :doc:`Kitchen </kitchen>`, `chef-zero (a command-line tool that runs locally as if it were connected to a real Chef server) <https://docs.chef.io/ctl_chef_client.html#run-in-local-mode>`__, command-line tools like :doc:`Knife (for interacting with the Chef server) </knife>` and :doc:`chef (for interacting with your local chef-repo) </ctl_chef>`, and resources like :doc:`core Chef resources (for building recipes) </resources>` and :doc:`InSpec (for building security and compliance checks into your workflow) </inspec_reference>`.
* Nodes are the machines---physical, virtual, cloud, and so on---that are under management by |chef|. The chef-client is installed on each node and is what `performs the automation on that machine <https://docs.chef.io/chef_client.html#the-chef-client-title-run>`__.
* Use the |chef server| as your foundation to create and manage flexible, dynamic infrastructure whether you manage 50 or 500,000 nodes, across multiple datacenters, public and private clouds, and in heterogeneous environments.

  The Chef server acts as :doc:`a hub for configuration data </server_components>`. The Chef server stores cookbooks, the policies that are applied to nodes, and metadata that describes each registered node that is being managed by the chef-client. Nodes use the chef-client to ask the Chef server for configuration details, such as recipes, templates, and file distributions. The chef-client then does as much of the configuration work as possible on the nodes themselves (and not on the Chef server). This scalable approach distributes the configuration effort throughout the organization.
