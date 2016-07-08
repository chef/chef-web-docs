=====================================================
An Overview of |chef|
=====================================================

.. include:: ../../includes_chef/includes_chef.rst


* The workstation is the location from which all of |chef| is managed, including :doc:`installing the Chef DK </install_dk>`, :doc:`authoring cookbooks </cookbooks>`, and using tools like :doc:`Kitchen </kitchen>`, `chef-zero (a command-line tool that runs locally as if it were connected to a real Chef server) <https://docs.chef.io/ctl_chef_client.html#run-in-local-mode>`__, command-line tools like :doc:`Knife (for interacting with the Chef server) </knife>` and :doc:`chef (for interacting with your local chef-repo) </ctl_chef>`, and resources like :doc:`core Chef resources (for building recipes) </resources>` and :doc:`InSpec (for building security and compliance checks into your workflow) </inspec_reference>`.
* Nodes are the machines---physical, virtual, cloud, and so on---that are under management by |chef|. The chef-client is installed on each node and is what `performs the automation on that machine <https://docs.chef.io/chef_client.html#the-chef-client-title-run>`__.
* Use the |chef server| as your foundation to create and manage flexible, dynamic infrastructure whether you manage 50 or 500,000 nodes, across multiple datacenters, public and private clouds, and in heterogeneous environments.

  The Chef server acts as :doc:`a hub for configuration data </server_components>`. The Chef server stores cookbooks, the policies that are applied to nodes, and metadata that describes each registered node that is being managed by the chef-client. Nodes use the chef-client to ask the Chef server for configuration details, such as recipes, templates, and file distributions. The chef-client then does as much of the configuration work as possible on the nodes themselves (and not on the Chef server). This scalable approach distributes the configuration effort throughout the organization.


|chef| Components
=====================================================
The following diagram shows the relationships between the various elements of |chef|, including the nodes, the server, and the workstation. These elements work together to provide the |chef client| the information and instruction that it needs so that it can do its job. As you are reviewing the rest of this topic, use the icons in the tables to refer back to this image.

.. image:: ../../images/chef_overview.svg
   :width: 600px
   :align: center

.. include:: ../../includes_chef/includes_chef_key_elements.rst

|chef manage|, |chef client| run reporting, high availability configurations, and |chef server| replication are available as part of |delivery|.

The following sections discuss these elements (and their various components) in more detail.

Workstations
=====================================================
.. include:: ../../includes_workstation/includes_workstation.rst

While |chef| includes tooling like the |chef dk|, encourages integration and unit testing, and defines workflow around cookbook authoring and policy, it's important to note that you know best about how your infrastructure should be put together. Therefore, |chef| makes as few decisions on its own as possible. When a decision must be made, the |chef client| uses a reasonable default setting that can be easily changed. While |chef| encourages the use of the tooling packaged in the |chef dk|, none of these tools should be seen as a requirement or pre-requisite for being successful using |chef|.

Tools
-----------------------------------------------------
.. include:: ../../includes_workstation/includes_workstation_components.rst

Cookbooks
=====================================================
.. include:: ../../includes_cookbooks/includes_cookbooks.rst

The |chef client| uses |ruby| as its reference language for creating cookbooks and defining recipes, with an extended DSL for specific resources. A reasonable set of resources are available to the |chef client|, enough to support many of the most common infrastructure automation scenarios; however, this DSL can also be extended when additional resources and capabilities are required.

Components
-----------------------------------------------------
.. include:: ../../includes_cookbooks/includes_cookbooks_12-4_components.rst

Nodes
=====================================================
.. include:: ../../includes_node/includes_node.rst

Node Types
-----------------------------------------------------
.. include:: ../../includes_node/includes_node_types.rst

|chef| on Nodes
-----------------------------------------------------
.. include:: ../../includes_node/includes_node_components.rst

The |chef server_title|
=====================================================
.. include:: ../../includes_chef_server/includes_chef_server.rst

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Feature
     - Description
   * - .. image:: ../../images/icon_search.svg
          :width: 100px
          :align: center

     - .. include:: ../../includes_search/includes_search.rst
   * - .. image:: ../../images/icon_manage.svg
          :width: 100px
          :align: center

     - .. include:: ../../includes_chef/includes_chef_manager.rst
   * - .. image:: ../../images/icon_data_bags.svg
          :width: 100px
          :align: center

     - .. include:: ../../includes_data_bag/includes_data_bag.rst
   * - .. image:: ../../images/icon_policy.svg
          :width: 100px
          :align: center

     - Policy defines how business and operational requirements, processes, and production workflows map to objects that are stored on the |chef server|. Policy objects on the |chef server| include roles, environments, and cookbook versions.

Policy
-----------------------------------------------------
.. include:: ../../includes_policy/includes_policy.rst

Some important aspects of policy include:

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Feature
     - Description
   * - .. image:: ../../images/icon_roles.svg
          :width: 100px
          :align: center

     - .. include:: ../../includes_role/includes_role.rst
   * - .. image:: ../../images/icon_environments.svg
          :width: 100px
          :align: center

     - .. include:: ../../includes_environment/includes_environment.rst
   * - .. image:: ../../images/icon_cookbook_versions.svg
          :width: 100px
          :align: center

     - .. include:: ../../includes_cookbooks/includes_cookbooks_version.rst
   * - .. image:: ../../images/icon_run_lists.svg
          :width: 100px
          :align: center

     - .. include:: ../../includes_node/includes_node_run_list.rst


Conclusion
=====================================================
.. include:: ../../includes_chef/includes_chef_about.rst
