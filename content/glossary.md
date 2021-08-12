+++
title = "Glossary"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/glossary.html"]
product = ["automate", "client", "server", "habitat", "inspec", "workstation"]

[menu]
  [menu.infra]
 title = "Glossary"
 identifier = "chef_infra/reference/glossary.md Glossary"
 parent = "chef_infra/reference"
+++

Agent

: Agents are programs that you configure to perform actions continuously and autonomously.

Automate

: A full suite of enterprise capabilities for maintaining continuous visibility into application, infrastructure, and security automation.

Berkshelf

:   The legacy tool for managing cookbook dependencies. Policyfiles should be used instead.

chef

: `chef` is the Chef Workstation command line tool for managing your Chef development environment including repositories, cookbooks, recipes, attributes, templates, custom resources, and Ruby dependencies.

chef-client

: The `chef-client` is an agent that runs on nodes and a command line tool that runs on your local computer. The `chef-client` allows you to ensure the configuration of your systems through policy code. You install the chef-client on to nodes with the bootstrap process from your computer and configure it to run on an interval to ensure configuration compliance. You use the chef-client command line tool from your workstation to send instructions to the agent.

chef-apply

: A command-line tool that allows a single recipe to be run from the command line.

ChefDK

: The legacy package of tools for developing Chef Infra cookbooks. This product has been superseded by Chef Workstation which should be used instead.

Chef Infra Client

: A command-line tool that that runs Chef. Also, the name of Chef as it is installed on a node.

Chef Workstation

: A collection of tools to aide in development of Chef Infra cookbooks. It uses the full stack installer to give you everything you need to get going in one package. You can download it at [Chef Workstation](https://downloads.chef.io/chef-workstation/).

chef-repo

: The repository structure in which cookbooks are authored, tested, and maintained. View [an example of the](https://github.com/chef/chef-repo) chef-repo.

Chef Infra Server

: The Chef Infra Server acts as a hub for configuration data. The Chef Infra Server stores cookbooks, the policies that are applied to nodes, and metadata that describes each registered node that is being managed by Chef Infra Client. Nodes use Chef Infra Client to ask the Chef Infra Server for configuration details, such as recipes, templates, and file distributions.

ChefSpec

: ChefSpec is a unit-testing framework for testing Chef Infra cookbooks.

chef-zero

: A very lightweight Chef Infra Server that runs in-memory on the local machine during a Chef Infra Client run. Also known as local mode.

cookbook

: A cookbook is the fundamental unit of configuration and policy distribution in Chef Infra.

Cookstyle

: A linting tool that helps you write better Chef Infra cookbooks by detecting and automatically correcting style, syntax, and logic mistakes in your code.

custom resource

: An extension to Chef Infra Client that allows you to ship your own reusable resources within a cookbook.

data bag

: A data_bag is a global variable that is stored as JSON data and is accessible from a Chef Infra Server.

definition

: A definition is code that is reused across recipes, similar to a compile-time macro, and is defined in a cookbook. Definitions are not recommended for new users and Custom Resources should be written for reusable code instead.

environment

: An environment is a way to map an organization's real-life workflow to what can be configured and managed when using Chef Infra Server.

Foodcritic

: A legacy linting tool for doing static code analysis on cookbooks. This tool has been replaced with Cookstyle which should be used instead.

knife

: A command-line tool that provides an interface between a local chef-repo and the Chef Infra Server. Use it to manage nodes, cookbooks, recipes, roles, data bags, environments, bootstrapping nodes, searching the Chef Infra Server, and more.

library

: A library allows arbitrary Ruby code to be included in a cookbook, either as a way of extending the classes that are built-in to Chef Infra Client or by implementing entirely new functionality.

node

: A node is any physical, virtual, or cloud device that is configured and maintained by an instance of Chef Infra Client.

node object

: A node object is a history of the attributes, run-lists, and roles that were used to configure a node that is under management by Chef Infra.

ohai

: Ohai is a tool that is used to detect attributes on a node, and then provide these attributes to Chef Infra Client at the start of every run.

organization

: An organization is a single instance of a Chef Infra Server, including all of the nodes that are managed by that Chef Infra Server and each of the workstations that will run knife and access the Chef Infra Server using the Chef Infra Server API.

policy

: Policy settings can be used to map business and operational requirements, such as process and workflow, to settings and objects stored on the Chef Infra Server. See roles, environments, and data bags.

recipe

: A recipe is a collection of resources that tells Chef Infra Client how to configure a node.

resource

: A resource is a statement of configuration policy that describes the desired state of an piece within your infrastructure, along with the steps needed to bring that item to the desired state.

role

A role is a way to define certain patterns and processes that exist across nodes in an organization as belonging to a single job function.

run-list

: A run-list defines all of the configuration settings that are necessary for a node that is under management by Chef to be put into the desired state and the order in which these configuration settings are applied.

Test Kitchen

: Test Kitchen is an integration framework that is used to automatically test cookbook data across any combination of platforms and test suites. Test Kitchen is packaged in Chef Workstation.

Unified Mode

: Unified mode combines the compile and converge stages of the Chef Infra Client run into one phase. Unified mode means that the Chef Infra Client compiles and applies a custom resource in order, from top to bottom. Unified mode works only on custom resources and does not affect other resources or recipes.
