.. THIS PAGE DOCUMENTS chef-client version 11.0

=====================================================
About Cookbooks
=====================================================

.. include:: ../../includes_cookbooks/includes_cookbooks.rst

The chef-client uses Ruby as its reference language for creating cookbooks and defining recipes, with an extended DSL for specific resources. The chef-client provides a reasonable set of resources, enough to support many of the most common infrastructure automation scenarios; however, this DSL can also be extended when additional resources and capabilities are required.

Components
=====================================================
Some important components of cookbooks include:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Feature
     - Description
   * - :doc:`Attributes </attributes>`
     - .. include:: ../../includes_cookbooks/includes_cookbooks_attribute.rst
   * - :doc:`Recipes </recipes>`
     - .. include:: ../../includes_cookbooks/includes_cookbooks_recipe.rst

The chef-client will run a recipe only when asked. When the chef-client runs the same recipe more than once, the results will be the same system state each time. When a recipe is run against a system, but nothing has changed on either the system or in the recipe, the chef-client won't change anything.

In addition to attributes and recipes, the following items are also part of cookbooks:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Components
     - Description
   * - :doc:`Definitions </definitions>`
     - A definition is used to create new resources by stringing together one (or more) existing resources.
   * - :doc:`Files </files>`
     - A file distribution is a specific type of resource that tells a cookbook how to distribute files, including by node, by platform, or by file version.
   * - :doc:`Libraries </libraries>`
     - A library allows the use of arbitrary Ruby code in a cookbook, either as a way to extend the chef-client language or to implement a new class.
   * - :doc:`Custom Resources </custom_resources>`
     - A custom resource is an abstract approach for defining a set of actions and (for each action) a set of properties and validation parameters.
   * - :doc:`Metadata </cookbook_repo>`
     - A metadata file is used to ensure that each cookbook is correctly deployed to each node.\
   * - :doc:`Resources and Providers </resource>`
     - A resource is a package, a service, a group of users, and so on. A resource tells the chef-client which provider to use during a chef-client run for various tasks like installing packages, running Ruby code, or accessing directories and file systems. The resource is generic: "install program A" while the provider knows what to do with that process on Debian and Ubuntu and Microsoft Windows. A provider defines the steps that are required to bring that piece of the system into the desired state. The chef-client includes default providers that cover all of the most common scenarios. For the full list of resources that are built-in to the chef-client, see https://docs.chef.io/resources.html.
   * - :doc:`Templates </templates>`
     - A template is a file written in markup language that uses Ruby statements to solve complex configuration scenarios.
   * - :doc:`Cookbook Versions </cookbook_versions>`
     - .. include:: ../../includes_cookbooks/includes_cookbooks_version.rst

Community Cookbooks
=====================================================
Chef maintains a large collection of cookbooks. In addition, there are thousands of cookbooks created and maintained by the community:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Components
     - Description
   * - `Cookbooks Maintained by Chef <https://github.com/chef-cookbooks>`_
     - Chef maintains a collection of cookbooks that are widely used by the community.
   * - `Cookbooks Maintained by the Community <https://supermarket.chef.io/cookbooks>`_
     - The community has authored thousands of cookbooks, ranging from niche cookbooks that are used by only a few organizations to cookbooks that are some of the most popular and are used by nearly everyone.
