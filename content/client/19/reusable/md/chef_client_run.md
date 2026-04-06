A _Chef Infra Client run_ describes the steps Chef Infra Client takes to configure a node when you run the `chef-client` command.
The following diagram shows the various stages that occur during a Chef Infra Client run.

<!-- markdownlint-disable MD033 -->

![Flowchart diagram illustrating the sequential stages of a Chef Infra Client run, starting with getting configuration data and ending with waiting for the next run, with arrows connecting each step in a vertical flow.](/images/chef_run.svg)

During every Chef Infra Client run, the following happens:

1. **Get configuration data**

   Chef Infra Client gets process configuration data from the [`client.rb`](/install/config_rb_client/) file on the [node](/overview/nodes/) and then gets node configuration data from Ohai.
   The node name is an important piece of configuration data.
   Chef Infra Client gets the node name from the `node_name` attribute in the `client.rb` file or from Ohai.
   If Ohai provides the node name, it's typically the FQDN for the node, which is always unique within an organization.

1. **Authenticate to Chef Infra Server**

   Chef Infra Client [authenticates](https://docs.chef.io/server/auth/) to Chef Infra Server using an RSA private key and the Chef Infra Server API.
   Authentication with Infra Server requires the node name.
   If this is the first Chef Infra Client run for a node, the chef-validator generates an RSA private key.

1. **Get and rebuild the node object**

   Chef Infra Client pulls down the node object from Chef Infra Server and then rebuilds it.
   A node object contains the system attributes discovered by Ohai, the attributes set in Policyfiles or Cookbooks, and the run-list of cookbooks.
   The first time Chef Infra Client runs on a node, it creates a node object from the default run-list.
   A node that hasn't yet had a Chef Infra Client run won't have a node object or a Chef Infra Server entry for a node object.
   On any subsequent Chef Infra Client runs, the rebuilt node object also contains the run-list from the previous Chef Infra Client run.

1. **Expand the run-list**

   Chef Infra Client expands the [run-list](/policy/run_lists/) from the rebuilt node object and compiles a complete list of recipes in the exact order that they will be applied to the node.

1. **Synchronize cookbooks**

   Chef Infra Client requests all the [cookbook files](/cookbooks/) (including recipes, templates, resources, providers, attributes, and libraries) that it needs for every action identified in the run-list from Chef Infra Server.
   Chef Infra Server responds to Chef Infra Client with the complete list of files.
   Chef Infra Client compares the list of files to the files that already exist on the node from previous runs and then downloads a copy of every new or modified file from Chef Infra Server.

1. **Reset node attributes**

   All attributes in the rebuilt node object are reset.
   All attributes from attribute files, Policyfiles, and Ohai are loaded.
   Attributes that are defined in attribute files are first loaded according to cookbook order.
   For each cookbook, attributes in the `default.rb` file are loaded first, and then additional attribute files (if present) are loaded in lexical sort order.
   If attribute files are found within any cookbooks that are listed as dependencies in the `metadata.rb` file, these are loaded as well.
   All attributes in the rebuilt node object are updated with the attribute data according to attribute precedence.
   When all the attributes are updated, the rebuilt node object is complete.

1. **Compile the resource collection**

   Chef Infra Client identifies each resource in the node object and builds the resource collection.
   Libraries are loaded first to ensure that all language extensions and Ruby classes are available to all resources.
   Next, attributes are loaded, followed by custom resources.
   Finally, all recipes are loaded in the order specified by the expanded run-list.
   This is the _compile phase_.

1. **Converge the node**

   Chef Infra Client configures the system based on the information that has been collected.
   Each resource is executed in the order identified by the run-list and then by the order in which each resource is listed in each recipe.
   Each resource defines an action to run, which configures a specific part of the system.
   This process, called convergence, is also called the _execution phase_.

1. **Update the node object and process exception and report handlers**

   When all the actions identified by resources in the resource collection have been completed and Chef Infra Client finishes successfully, Chef Infra Client updates the node object on Chef Infra Server with the node object built during the Chef Infra Client run.
   Chef Infra Client will pull down this node object during the next Chef Infra Client run.
   This makes the node object (and the data in the node object) available for search.

   Chef Infra Client always checks the resource collection for the presence of exception and report handlers.
   If any are present, each one is processed appropriately.

1. **Get and run Chef InSpec Compliance Profiles**

   After the Chef Infra Client run finishes, it begins the [Compliance Phase](/features/chef_compliance_phase/), which is a Chef InSpec run within the Chef Infra Client. Chef InSpec retrieves tests from either a legacy audit cookbook or a current InSpec profile.

1. **Send or save Compliance Report**

   When all the InSpec tests finish running, Chef InSpec checks the reporting handlers defined in the legacy audit cookbook or in a current InSpec profile and processes them appropriately.

1. **Stop and wait for the next run**

   When everything is configured and the Chef Infra Client run is complete, Chef Infra Client stops and waits until the next time it's asked to run.
