=====================================================
About Policy
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/policy.rst>`__

.. tag policy_summary

Policy maps business and operational requirements, process, and workflow to settings and objects stored on the Chef Infra Server:

* Roles define server types, such as "web server" or "database server"
* Environments define process, such as "dev", "staging", or "production"
* Certain types of data---passwords, user account data, and other sensitive items---can be placed in data bags, which are located in a secure sub-area on the Chef Infra Server that can only be accessed by nodes that authenticate to the Chef Infra Server with the correct SSL certificates
* The cookbooks (and cookbook versions) in which organization-specific configuration policies are maintained

.. end_tag

Cookbook Versions
=====================================================
.. tag cookbooks_version

A cookbook version represents a set of functionality that is different from the cookbook on which it is based. A version may exist for many reasons, such as ensuring the correct use of a third-party component, updating a bug fix, or adding an improvement. A cookbook version is defined using syntax and operators, may be associated with environments, cookbook metadata, and/or run-lists, and may be frozen (to prevent unwanted updates from being made).

A cookbook version is maintained just like a cookbook, with regard to source control, uploading it to the Chef Infra Server, and how Chef Infra Client applies that cookbook when configuring nodes.

.. end_tag

.. note:: For more information about cookbook versioning, see `About Cookbook Versioning </cookbook_versioning.html>`__

Data Bags (Secrets)
=====================================================
.. tag data_bag

Data bags store global variables as JSON data. Data bags are indexed for searching and can be loaded by a cookbook or accessed during a search.

.. end_tag

.. note:: For more information about data bags, see `About Data Bags </data_bags.html>`__

Environments
=====================================================
.. tag environment

An environment is a way to map an organization's real-life workflow to what can be configured and managed when using Chef Infra. Every organization begins with a single environment called the ``_default`` environment, which cannot be modified (or deleted). Additional environments can be created to reflect each organization's patterns and workflow. For example, creating ``production``, ``staging``, ``testing``, and ``development`` environments.

.. end_tag

.. note:: For more information about environments, see `About Environments </environments.html>`__

Roles
=====================================================
.. tag role

A role is a way to define certain patterns and processes that exist across nodes in an organization as belonging to a single job function. Each role consists of zero (or more) attributes and a run-list. Each node can have zero (or more) roles assigned to it. When a role is run against a node, the configuration details of that node are compared against the attributes of the role, and then the contents of that role's run-list are applied to the node's configuration details. When a Chef Infra Client runs, it merges its own attributes and run-lists with those contained within each assigned role.

.. end_tag

.. note:: For more information about roles, see `About Roles </roles.html>`__

Policyfile
=====================================================
.. tag policyfile_summary

A Policyfile is an optional way to manage role, environment, and community cookbook data with a single document that is uploaded to the Chef Infra Server. The file is associated with a group of nodes, cookbooks, and settings. When these nodes perform a Chef Infra Client run, they utilize recipes specified in the Policyfile run-list.

.. end_tag

.. note:: For more information about Policyfile, see `About Policyfile </policyfile.html>`__
