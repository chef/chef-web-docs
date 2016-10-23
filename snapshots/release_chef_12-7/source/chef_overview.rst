.. THIS PAGE IS IDENTICAL TO docs.chef.io/chef_overview.html BY DESIGN
.. THIS PAGE DOCUMENTS chef-client version 12.7

=====================================================
An Overview of Chef
=====================================================

Welcome to Chef!

.. include:: ../../includes_chef/includes_chef.rst


Chef Components
=====================================================
The following diagram shows the relationships between the various elements of Chef, including the nodes, the server, premium features of the server, and the workstation. These elements work together to provide the chef-client the information and instruction that it needs so that it can do its job. As you are reviewing the rest of this topic, use the icons in the tables to refer back to this image.

.. image:: ../../images/chef_overview.svg
   :width: 600px
   :align: center

.. include:: ../../includes_chef/includes_chef_key_elements.rst

The premium features of the Chef server---Chef management console, Chef Analytics, chef-client run reporting, high availability configurations, and Chef server replication---may all be installed and configured for use with the Chef server. Each of these premium features are easily enabled and can be run as part of any Chef server deployment!

The following sections discuss these elements (and their various components) in more detail.


Workstations
=====================================================
.. include:: ../../includes_workstation/includes_workstation.rst

While Chef includes tooling like the Chef development kit, encourages integration and unit testing, and defines workflow around cookbook authoring and policy, it's important to note that you know best about how your infrastructure should be put together. Therefore, Chef makes as few decisions on its own as possible. When a decision must be made, the chef-client uses a reasonable default setting that can be easily changed. While Chef encourages the use of the tooling packaged in the Chef development kit, none of these tools should be seen as a requirement or pre-requisite for being successful using Chef.

Tools
-----------------------------------------------------
.. include:: ../../includes_workstation/includes_workstation_components.rst


Cookbooks
=====================================================
.. include:: ../../includes_cookbooks/includes_cookbooks.rst

The chef-client uses Ruby as its reference language for creating cookbooks and defining recipes, with an extended DSL for specific resources. A reasonable set of resources are available to the chef-client, enough to support many of the most common infrastructure automation scenarios; however, this DSL can also be extended when additional resources and capabilities are required.

Components
-----------------------------------------------------
.. include:: ../../includes_cookbooks/includes_cookbooks_components.rst


Nodes
=====================================================
.. include:: ../../includes_node/includes_node.rst

Node Types
-----------------------------------------------------
.. include:: ../../includes_node/includes_node_types.rst

Chef on Nodes
-----------------------------------------------------
.. include:: ../../includes_node/includes_node_components.rst


The Chef Server
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

     - Policy defines how business and operational requirements, processes, and production workflows map to objects that are stored on the Chef server. Policy objects on the Chef server include roles, environments, and cookbook versions.


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


Analytics
=====================================================
.. include:: ../../includes_analytics/includes_analytics.rst

Chef Analytics includes:

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Feature
     - Description
   * - .. image:: ../../images/icon_actions.svg
          :width: 100px
          :align: center

     - Actions are policy and administrative changes made to the Chef server. The Chef server gathers a lot of data—--each node object, the node run history for all nodes, the history of every cookbook and cookbook version, how policy settings, such as roles, environments, and data bags, are applied and to what they are applied, individual user data, and so on.
   * - .. image:: ../../images/icon_rules.svg
          :width: 100px
          :align: center

     - .. include:: ../../includes_analytics_rules/includes_analytics_rules.rst
   * - .. image:: ../../images/icon_reports.svg
          :width: 100px
          :align: center

     - Reporting is used to keep track of what happened during the execution of chef-client runs across all of the infrastructure that is being managed by Chef. Reports can be generated for the entire organization and they can be generated for specific nodes.
   * - .. image:: ../../images/icon_controls.svg
          :width: 100px
          :align: center

     - .. include:: ../../includes_analytics/includes_analytics_controls.rst



Conclusion
=====================================================
.. include:: ../../includes_chef/includes_chef_about.rst
