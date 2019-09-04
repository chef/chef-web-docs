+++
title = "An Overview of Chef Infra"
draft = false

aliases = "/chef_overview.html"

[menu]
  [menu.docs]
    title = "Chef Infra Overview"
    identifier = "chef_infra/getting_started/chef_overview.md Chef Infra Overview"
    parent = "chef_infra/getting_started"
    weight = 10
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/chef_overview.rst)

{{% chef %}}

-   **Chef Workstation** is the location where users interact with Chef.
    With Chef Workstation, users can author and test
    [cookbooks](/cookbooks/) using tools such as [Test
    Kitchen](/kitchen/) and interact with the Chef Infra Server
    using the [knife](/knife/) and [chef](/ctl_chef/) command
    line tools.
-   **Chef Infra Client nodes** are the machines that are managed by
    Chef. The Chef Infra Client is installed on each node and is used to
    configure the node to its desired state.
-   **Chef Infra Server** acts as [a hub for configuration
    data](/server_overview/). Chef Infra Server stores cookbooks,
    the policies that are applied to nodes, and metadata that describes
    each registered node that is being managed by Chef. Nodes use the
    Chef Infra Client to ask the Chef Infra Server for configuration
    details, such as recipes, templates, and file distributions.

Chef Components
===============

The following diagram shows the relationships between the various
elements of Chef, including the nodes, the server, and the workstation.
These elements work together to provide the Chef Infra Client the
information and instruction that it needs so that it can do its job. As
you are reviewing the rest of this topic, use the icons in the tables to
refer back to this image.

<img src="/images/chef_overview.svg" class="align-center" width="600" alt="image" />

Chef has the following major components:

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Component</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><img src="/images/icon_workstation.svg" class="align-center" width="100" alt="image" /></p>
<p><img src="/images/icon_cookbook.svg" class="align-center" width="100" alt="image" /></p>
<p><img src="/images/icon_ruby.svg" class="align-center" width="100" alt="image" /></p></td>
<td><p>One (or more) workstations are configured to allow users to author, test, and maintain cookbooks. Cookbooks are uploaded to the Chef Infra Server from the workstation. Some cookbooks are custom to the organization and others are based on community cookbooks available from the Chef Supermarket.</p>
<p>Ruby is the programming language that is the authoring syntax for cookbooks. Most recipes are simple patterns (blocks that define properties and values that map to specific configuration items like packages, files, services, templates, and users). The full power of Ruby is available for when you need a programming language.</p>
<p>Often, a workstation is configured to use Chef Workstation as the development toolkit. Chef Workstation is a package from Chef that provides a recommended set of tooling, including Chef itself, the chef command line tool, Test Kitchen, ChefSpec, and more.</p></td>
</tr>
<tr class="even">
<td><p><img src="/images/icon_node.svg" class="align-center" width="100" alt="image" /></p>
<p><img src="/images/icon_chef_client.svg" class="align-center" width="100" alt="image" /></p></td>
<td><p>{{% node %}}</p>
<p>A Chef Infra Client is installed on each node that is under management by Chef. The Chef Infra Client performs all of the configuration tasks that are specified by the run-list and will pull down any required configuration data from the Chef Infra Server as it is needed during a Chef Infra Client run.</p></td>
</tr>
<tr class="odd">
<td><p><img src="/images/icon_chef_server.svg" class="align-center" width="100" alt="image" /></p></td>
<td><p>The Chef Infra Server acts as a hub of information. Cookbooks and policy settings are uploaded to the Chef Infra Server by users from workstations. (Policy settings may also be maintained from the Chef Infra Server itself, via the Chef management console web user interface.)</p>
<p>The Chef Infra Client accesses the Chef Infra Server from the node on which it's installed to get configuration data, performs searches of historical Chef Infra Client run data, and then pulls down the necessary configuration data. After a Chef Infra Client run is finished, the Chef Infra Client uploads updated run data to the Chef Infra Server.</p>
<p>Chef management console is the user interface for the Chef Infra Server. It is used to manage data bags, attributes, run-lists, roles, environments, and cookbooks, and also to configure role-based access for users and groups.</p></td>
</tr>
<tr class="even">
<td><img src="/images/icon_chef_supermarket.svg" class="align-center" width="100" alt="image" /></td>
<td>Chef Supermarket is the location in which community cookbooks are shared and managed. Cookbooks that are part of the Chef Supermarket may be used by any Chef user. How community cookbooks are used varies from organization to organization.</td>
</tr>
</tbody>
</table>

Chef management console, Chef Infra Client run reporting, high
availability configurations, and Chef Infra Server replication are
available as part of Chef Automate.

The following sections discuss these elements (and their various
components) in more detail.

Workstations
============

{{% workstation_summary %}}

[Chef Workstation](https://downloads.chef.io/chef-workstation/) gives
you everything you need to get started with Chef — ad hoc remote
execution, remote scanning, configuration tasks, cookbook creation tools
as well as robust dependency and testing software — all in one
easy-to-install package. Chef Workstation replaces ChefDK, combining all
the existing features with new features, such as ad-hoc task support and
the new Chef Workstation desktop application. Chef will continue to
maintain ChefDK, but new development will take place in Chef Workstation
without backporting features.

Chef Workstation Components and Tools
-------------------------------------

Some important tools and components of Chef Workstation include:

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Component</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><img src="/images/icon_devkit.svg" class="align-center" width="100" alt="image" /></td>
<td>{{% chef_dk %}}</td>
</tr>
<tr class="even">
<td><p><img src="/images/icon_ctl_chef.svg" class="align-center" width="100" alt="image" /></p>
<p><img src="/images/icon_ctl_knife.svg" class="align-center" width="100" alt="image" /></p></td>
<td><p>Chef Workstation includes important command-line tools:</p>
<ul>
<li>Chef Infra: Use the chef command-line tool to work with items in a chef-repo, which is the primary location in which cookbooks are authored, tested, and maintained, and from which policy is uploaded to the Chef Infra Server</li>
<li>Knife: Use the knife command-line tool to interact with nodes or work with objects on the Chef Infra Server</li>
<li>Chef Infra Client: an agent that configures your nodes</li>
<li>Test Kitchen: a testing harness for rapid validation of Chef code</li>
<li>Chef InSpec: Chef's open source security &amp; compliance automation framework</li>
<li>chef-run: a tool for running ad-hoc tasks</li>
<li>Chef Workstation App: for updating and managing your chef tools</li>
</ul></td>
</tr>
<tr class="odd">
<td><p><img src="/images/icon_repository.svg" class="align-center" width="100" alt="image" /></p></td>
<td><p>{{% chef_repo_summary %}}</p>
<p>{{% chef_repo_structure %}}</p></td>
</tr>
<tr class="even">
<td><img src="/images/icon_kitchen.svg" class="align-center" width="100" alt="image" /></td>
<td>{{% test_kitchen %}}</td>
</tr>
<tr class="odd">
<td><img src="/images/icon_chefspec.svg" class="align-center" width="100" alt="image" /></td>
<td>{{% chefspec_summary %}}</td>
</tr>
</tbody>
</table>

Cookbooks
=========

{{% cookbooks_summary %}}

The Chef Infra Client uses Ruby as its reference language for creating
cookbooks and defining recipes, with an extended DSL for specific
resources. A reasonable set of resources are available to the Chef Infra
Client, enough to support many of the most common infrastructure
automation scenarios; however, this DSL can also be extended when
additional resources and capabilities are required.

Components
----------

Cookbooks are comprised of the following components:

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Component</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><img src="/images/icon_cookbook_attributes.svg" class="align-center" width="100" alt="image" /></td>
<td>{{% cookbooks_attribute %}}</td>
</tr>
<tr class="even">
<td><img src="/images/icon_cookbook_files.svg" class="align-center" width="100" alt="image" /></td>
<td>{{% resource_cookbook_file_summary %}}</td>
</tr>
<tr class="odd">
<td><img src="/images/icon_cookbook_libraries.svg" class="align-center" width="100" alt="image" /></td>
<td>{{% libraries_summary %}}</td>
</tr>
<tr class="even">
<td><img src="/images/icon_cookbook_metadata.svg" class="align-center" width="100" alt="image" /></td>
<td>{{% cookbooks_metadata %}}</td>
</tr>
<tr class="odd">
<td><p><img src="/images/icon_cookbook_recipes.svg" class="align-center" width="100" alt="image" /></p>
<p><img src="/images/icon_recipe_dsl.svg" class="align-center" width="100" alt="image" /></p></td>
<td><p>{{% cookbooks_recipe %}}</p>
<p>The Chef Infra Client will run a recipe only when asked. When the Chef Infra Client runs the same recipe more than once, the results will be the same system state each time. When a recipe is run against a system, but nothing has changed on either the system or in the recipe, the Chef Infra Client won't change anything.</p>
<p>{{% dsl_recipe_summary %}}</p></td>
</tr>
<tr class="even">
<td><p><img src="/images/icon_cookbook_resources.svg" class="align-center" width="100" alt="image" /></p></td>
<td><p>{{% resources_common %}}</p>
<p>Chef has <a href="/resource_reference/">many built-in resources</a> that cover all of the most common actions across all of the most common platforms. You can <a href="/custom_resources/">build your own resources</a> to handle any situation that isn't covered by a built-in resource.</p></td>
</tr>
<tr class="odd">
<td><img src="/images/icon_cookbook_templates.svg" class="align-center" width="100" alt="image" /></td>
<td>{{% template %}}</td>
</tr>
<tr class="even">
<td><img src="/images/icon_cookbook_tests.svg" class="align-center" width="100" alt="image" /></td>
<td>Testing cookbooks improves the quality of those cookbooks by ensuring they are doing what they are supposed to do and that they are authored in a consistent manner. Unit and integration testing validates the recipes in cookbooks. Syntax testing---often called linting---validates the quality of the code itself. The following tools are popular tools used for testing Chef recipes: Test Kitchen, ChefSpec, and Foodcritic.</td>
</tr>
</tbody>
</table>

Nodes
=====

{{% node %}}

Node Types
----------

{{% node_types %}}

Chef on Nodes
-------------

The key components of nodes that are under management by Chef include:

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Component</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><img src="/images/icon_chef_client.svg" class="align-center" width="100" alt="image" /></p></td>
<td><p>{{% chef_client_summary %}}</p>
<p>{{% security_key_pairs_chef_client %}}</p></td>
</tr>
<tr class="even">
<td><img src="/images/icon_ohai.svg" class="align-center" width="100" alt="image" /></td>
<td>{{% ohai_summary %}}</td>
</tr>
</tbody>
</table>

The Chef Server
===============

{{% chef_server %}}

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Feature</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><img src="/images/icon_search.svg" class="align-center" width="100" alt="image" /></td>
<td>{{% search %}}</td>
</tr>
<tr class="even">
<td><img src="/images/icon_manage.svg" class="align-center" width="100" alt="image" /></td>
<td>{{% chef_manager %}}</td>
</tr>
<tr class="odd">
<td><img src="/images/icon_data_bags.svg" class="align-center" width="100" alt="image" /></td>
<td>{{% data_bag %}}</td>
</tr>
<tr class="even">
<td><img src="/images/icon_policy.svg" class="align-center" width="100" alt="image" /></td>
<td>Policy defines how business and operational requirements, processes, and production workflows map to objects that are stored on the Chef Infra Server. Policy objects on the Chef Infra Server include roles, environments, and cookbook versions.</td>
</tr>
</tbody>
</table>

Policy
------

{{% policy_summary %}}

Some important aspects of policy include:

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Feature</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><img src="/images/icon_roles.svg" class="align-center" width="100" alt="image" /></td>
<td>{{% role %}}</td>
</tr>
<tr class="even">
<td><img src="/images/icon_environments.svg" class="align-center" width="100" alt="image" /></td>
<td>{{% environment %}}</td>
</tr>
<tr class="odd">
<td><img src="/images/icon_cookbook_versions.svg" class="align-center" width="100" alt="image" /></td>
<td>{{% cookbooks_version %}}</td>
</tr>
<tr class="even">
<td><img src="/images/icon_run_lists.svg" class="align-center" width="100" alt="image" /></td>
<td>{{% node_run_list %}}</td>
</tr>
</tbody>
</table>

Conclusion
==========

{{% chef_about %}}
