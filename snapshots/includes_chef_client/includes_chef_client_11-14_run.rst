.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A "chef-client run" is the term used to describe a series of steps that are taken by the chef-client when it is configuring a node. The following diagram shows the various stages that occur during the chef-client run, and then the list below the diagram describes in greater detail each of those stages.

.. image:: ../../images/chef_run.png

During every chef-client run, the following happens:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Stages
     - Description
   * - **Get configuration data**
     - The chef-client gets process configuration data from the client.rb file on the node, and then gets node configuration data from Ohai. One important piece of configuration data is the name of the node, which is found in the ``node_name`` attribute in the client.rb file or is provided by Ohai. If Ohai provides the name of a node, it is typically the FQDN for the node, which is always unique within an organization.
   * - **Authenticate to the Chef Server**
     - The chef-client authenticates to the Chef server using an RSA private key and the Chef server API. The name of the node is required as part of the authentication process to the Chef server. If this is the first chef-client run for a node, the chef-validator will be used to generate the RSA private key.
   * - **Get, rebuild the node object**
     - The chef-client pulls down the node object from the Chef server. If this is the first chef-client run for the node, there will not be a node object to pull down from the Chef server. After the node object is pulled down from the Chef server, the chef-client rebuilds the node object. If this is the first chef-client run for the node, the rebuilt node object will contain only the default run-list. For any subsequent chef-client run, the rebuilt node object will also contain the run-list from the previous chef-client run.
   * - **Expand the run-list**
     - The chef-client expands the run-list from the rebuilt node object, compiling a full and complete list of roles and recipes that will be applied to the node, placing the roles and recipes in the same exact order they will be applied. (The run-list is stored in each node object's JSON file, grouped under ``run_list``.)
   * - **Synchronize cookbooks**
     - The chef-client asks the Chef server for a list of all cookbook files (including recipes, templates, resources, providers, attributes, libraries, and definitions) that will be required to do every action identified in the run-list for the rebuilt node object. The Chef server provides to the chef-client a list of all of those files. The chef-client compares this list to the cookbook files cached on the node (from previous chef-client runs), and downloads files and templates as they are required. (The chef-client may be configured to download files and templates up-front.)
   * - **Reset node attributes**
     - All attributes in the rebuilt node object are reset. All attributes from attribute files, environments, roles, and Ohai are loaded. All attributes in the rebuilt node object are updated with the attribute data according to attribute precedence. When all of the attributes are updated, the rebuilt node object is complete.
   * - **Compile the resource collection**
     - The chef-client identifies each resource in the node object and builds the resource collection. All libraries are loaded (to ensure that all language extensions and Ruby classes are available). And then all attributes are loaded. And then all lightweight resources are loaded. And then all definitions are loaded (to ensure that any pseudo-resources are available). Finally, all recipes are loaded in the order specified by the expanded run-list.
   * - **Converge the node**
     - The chef-client configures the system based on the information that has been collected. Each resource is executed in the order identified by the run-list, and then by the order in which each resource is listed in each recipe. Each resource in the resource collection is mapped to a provider. The provider examines the node, and then does the steps necessary to complete the action. And then the next resource is processed. Each action configures a specific part of the system. This process is also referred to as convergence.
   * - **Update the node object, process exception and report handlers**
     - When all of the actions identified by resources in the resource collection have been done, and when the chef-client run finished successfully, the chef-client updates the node object on the Chef server with the node object that was built during this chef-client run. (This node object will be pulled down by the chef-client during the next chef-client run.) This makes the node object (and the data in the node object) available for search. 

       The chef-client always checks the resource collection for the presence of exception and report handlers. If any are present, each one is processed appropriately.
   * - **Stop, wait for the next run**
     - When everything is configured and the chef-client run is complete, the chef-client stops and waits until the next time it is asked to run.
