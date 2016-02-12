=====================================================
Glossary
=====================================================


**Acceptance**
   A |chef delivery| stage. The Acceptance stage is where your team decides whether the submitted change should ship all the way out to its final destination.

**analytics rules**
   Event tracking during the |chef client| run that generates data made visible from |chef analytics|.

**Berkshelf**
   `Manage cookbook dependencies <http://berkshelf.com/>`__.

**Build**
   A |chef delivery| stage. The purpose of the Build stage is to assemble one or more potentially releasable artifacts and make them available to the remaining stages of the pipeline. Using |berkshelf| can help to `manage cookbook dependencies <http://berkshelf.com/>`__.

**Chef analytics**
   A feature of |chef| that provides real-time visibility into what is happening on the |chef server|, including what's changing, who made those changes, and when they occurred

**chef-apply**
   A command-line tool that allows a single recipe to be run from the command line.

**chef-client**
   A command-line tool that that runs |chef|. Also, the name of |chef| as it is installed on a node.

**Chef-DK**
   A collection of tools to help development of Chef and Chef resources. It uses the full stack installer to give you everything you need to get going in one package.  You can download it at `Chef Development Kit <https://downloads.chef.io/chef-dk/>`__.

**chef-repo**
   The repository structure in which cookbooks are authored, tested, and maintained. View `an example of the <https://github.com/chef/chef-repo>`__ |chef repo|.

**Chef server**
   The |chef server| acts as a hub for configuration data. The |chef server| stores cookbooks, the policies that are applied to nodes, and metadata that describes each registered node that is being managed by the |chef client|. Nodes use the |chef client| to ask the |chef server| for configuration details, such as recipes, templates, and file distributions.

**Chefspec**
   ChefSpec is a unit-testing framework for testing Chef cookbooks.

**chef-zero**
   A very lightweight |chef server| that runs in-memory on the local machine during the |chef client| run. Also known as local mode.

**cookbook**
   A cookbook is the fundamental unit of configuration and policy distribution.

**data bag**
   A data_bag is a global variable that is stored as |json| data and is accessible from a |chef server|.

**definition**
   A definition is code that is reused across recipes, similar to a compile-time macro, and is defined in a cookbook.

**Delivered**
   A |chef delivery| stage. Delivered is the final stage of the pipeline, what it means for your system is up to you. It could mean deploying the change so that it is live and receiving production traffic, or it might mean publishing a set of artifacts so they are accessible for your customers.

**Delivery**
   |chef delivery| manages changes to both infrastructure and application code, giving your operations and development teams a common platform for developing, building, testing, and deploying cookbooks, applications, and more. For more information see the `Delivery Overview <https://docs.chef.io/release/delivery_1-0/delivery_overview.html/>`__.

**environment**
   An environment is a way to map an organization's real-life workflow to what can be configured and managed when using |chef server|.

**foodcritic**
   A linting tool for doing static code analysis on cookbooks.

**kitchen**
   |kitchen| is an integration framework that is used to automatically test cookbook data across any combination of platforms and test suites. |kitchen| is packaged in the |chef dk|.

**knife**
   A command-line tool that provides an interface between a local |chef repo| and the |chef server|. Use it to manage nodes, cookbooks, recipes, roles, data bags, environments, bootstrapping nodes, searching the |chef server|, and more.

**library**
   A library allows arbitrary |ruby| code to be included in a cookbook, either as a way of extending the classes that are built-in to the |chef client| or by implementing entirely new functionality.

**Management Console**
   The Chef web-based management console you can use to manage Role Based Access Control (RBAC), edit and delete nodes, and reset private keys. Keep up to date with what's happening during chef client runs across an entire organization or on specific nodes.

**node**
   A node is any physical, virtual, or cloud machine that is configured to be maintained by a |chef client|.

**node object**
   A history of the attributes, run-lists, and roles that were used to configure a node that is under management by |chef|.

**ohai**
   Ohai is a tool that is used to detect attributes on a node, and then provide these attributes to the |chef client| at the start of every run.

**organization**
   An organization is a single instance of a |chef server|, including all of the nodes that are managed by that |chef server| and each of the workstations that will run |knife| and access the |chef server| using the |api chef server|.

**pipeline**
   A pipeline is series of automated and manual quality gates that take software changes from development to delivery. Pipelines in |chef delivery| have six stages: Verify, Build, Acceptance, Union, Rehearsal, and Delivered.

**policy**
   Policy settings can be used to map business and operational requirements, such as process and workflow, to settings and objects stored on the |chef server|. See roles, environments, and data bags.

**Push Jobs**
   Allows you to execute commands across hundreds or even thousands of nodes in your Chef-managed infrastructure.

**recipe**
   A recipe is a collection of resources that tells the |chef client| how to configure a node.

**Rehearsal**
   If all phases of Union succeed, then the Rehearsal stage is triggered. Rehearsal increases confidence in the artifacts and the deployment by repeating the process that occurred in Union in a different environment.

**Reporting**
   Capture and visualize what happens during the execution of chef-client runs across all of your Chef-managed infrastructure.

**resource**
   A resource is a statement of configuration policy that describes the desired state of an piece within your infrastructure, along with the steps needed to bring that item to the desired state.

**role**
   A role is a way to define certain patterns and processes that exist across nodes in an organization as belonging to a single job function.

**run_list**
   A run_list defines all of the configuration settings that are necessary for a node that is under management by |chef| to be put into the desired state and the order in which these configuration settings are applied.

**test-kitchen**
   See kitchen.

**Union**
  A |chef delivery| stage. Union is the first of the three shared pipeline stages. The purpose of the Union stage is to assess the impact of the change in the context of a complete (or as close as possible) installation of the set of projects that comprise the system as a whole.

**Verify**
  A |chef delivery| stage. The purpose of Verify is to run checks so that the system can decide if it's worth the time of a human to review the submitted change.
