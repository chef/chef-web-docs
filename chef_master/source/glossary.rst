=====================================================
Glossary
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/glossary.rst>`__

**analytics rules**
   Event tracking during a Chef Infra Client run that generates data made visible to Chef Automate.

**Berkshelf**
   Manage cookbook dependencies.

**chef-apply**
   A command-line tool that allows a single recipe to be run from the command line.

**Chef Infra Client**
   A command-line tool that that runs Chef. Also, the name of Chef as it is installed on a node.

**ChefDK**
   A collection of tools to aide in development of Chef cookbooks. It uses the full stack installer to give you everything you need to get going in one package. You can download it at `ChefDK <https://downloads.chef.io/chefdk/>`__.

**chef-repo**
   The repository structure in which cookbooks are authored, tested, and maintained. View `an example of the <https://github.com/chef/chef-repo>`__ chef-repo.

**Chef Infra Server**
   The Chef Infra Server acts as a hub for configuration data. The Chef Infra Server stores cookbooks, the policies that are applied to nodes, and metadata that describes each registered node that is being managed by Chef Infra Client. Nodes use Chef Infra Client to ask the Chef Infra Server for configuration details, such as recipes, templates, and file distributions.

**ChefSpec**
   ChefSpec is a unit-testing framework for testing Chef cookbooks.

**chef-zero**
   A very lightweight Chef Infra Server that runs in-memory on the local machine during a Chef Infra Client run. Also known as local mode.

**cookbook**
   A cookbook is the fundamental unit of configuration and policy distribution.

**Cookstyle**
   A linting tool that helps you write better Chef Infra cookbooks by detecting and automatically correcting style, syntax, and logic mistakes in your code.

**data bag**
   A data_bag is a global variable that is stored as JSON data and is accessible from a Chef Infra Server.

**definition**
   A definition is code that is reused across recipes, similar to a compile-time macro, and is defined in a cookbook.

**environment**
   An environment is a way to map an organization's real-life workflow to what can be configured and managed when using Chef Infra Server.

**Foodcritic**
   A linting tool for doing static code analysis on cookbooks.

**kitchen**
   Kitchen is an integration framework that is used to automatically test cookbook data across any combination of platforms and test suites. Kitchen is packaged in ChefDK.

**knife**
   A command-line tool that provides an interface between a local chef-repo and the Chef Infra Server. Use it to manage nodes, cookbooks, recipes, roles, data bags, environments, bootstrapping nodes, searching the Chef Infra Server, and more.

**library**
   A library allows arbitrary Ruby code to be included in a cookbook, either as a way of extending the classes that are built-in to Chef Infra Client or by implementing entirely new functionality.

**Management Console**
   The Chef web-based management console you can use to manage Role Based Access Control (RBAC), edit and delete nodes, and reset private keys. Keep up to date with what's happening during Chef Infra Client runs across an entire organization or on specific nodes.

**node**
   A node is any physical, virtual, or cloud device that is configured and maintained by an instance of Chef Infra Client.

**node object**
   A node object is a history of the attributes, run-lists, and roles that were used to configure a node that is under management by Chef Infra.

**ohai**
   Ohai is a tool that is used to detect attributes on a node, and then provide these attributes to Chef Infra Client at the start of every run.

**organization**
   An organization is a single instance of a Chef Infra Server, including all of the nodes that are managed by that Chef Infra Server and each of the workstations that will run knife and access the Chef Infra Server using the Chef Infra Server API.

**pipeline**
   A pipeline is series of automated and manual quality gates that take software changes from development to delivery.

**policy**
   Policy settings can be used to map business and operational requirements, such as process and workflow, to settings and objects stored on the Chef Infra Server. See roles, environments, and data bags.

**Push Jobs**
   Allows you to execute commands across hundreds or even thousands of nodes in your Chef-managed infrastructure.

**recipe**
   A recipe is a collection of resources that tells Chef Infra Client how to configure a node.

**Reporting**
   Capture and visualize what happens during the execution of Chef Infra Client runs across all of your Chef-managed infrastructure.

**resource**
   A resource is a statement of configuration policy that describes the desired state of an piece within your infrastructure, along with the steps needed to bring that item to the desired state.

**role**
   A role is a way to define certain patterns and processes that exist across nodes in an organization as belonging to a single job function.

**run-list**
   A run-list defines all of the configuration settings that are necessary for a node that is under management by Chef to be put into the desired state and the order in which these configuration settings are applied.

**test-kitchen**
   See kitchen.

**visibility**
   A feature of Chef Automate that provides real-time visibility into what is happening on the Chef Infra Server, including what's changing, who made those changes, and when they occurred.
