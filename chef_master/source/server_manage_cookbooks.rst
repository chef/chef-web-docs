=====================================================
Manage Cookbooks
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/server_manage_cookbooks.rst>`__

.. meta:: 
    :robots: noindex 

.. tag EOL_manage

.. warning:: Chef Manage is `deprecated </versions.html#deprecated-products-and-versions>`__. The `Chef Enterprise Automation Stack <https://www.chef.io/products/enterprise-automation-stack>`_ allows you to define infrastructure, security policies, and application dependencies as code, deliver the stack via an automated pipeline to any platform, and deploy, observe, and manage the stack over its lifecycle. Chef Automate is included as part of the Chef license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

.. end_tag


.. note:: This topic is about using the Chef management console to manage cookbooks.

.. tag cookbooks_summary

A cookbook is the fundamental unit of configuration and policy distribution. A cookbook defines a scenario and contains everything that is required to support that scenario:

* Recipes that specify the resources to use and the order in which they are to be applied
* Attribute values
* File distributions
* Templates
* Extensions to Chef, such as custom resources and libraries

.. end_tag

Manage
=====================================================
Cookbooks can be viewed from the Chef management console web user interface. Cookbooks are managed using knife.

View Cookbook Details
-----------------------------------------------------
To view cookbook details:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Cookbooks**.
#. Select a cookbook.
#. Click the **Details** tab:

   .. image:: ../../images/step_manage_webui_policy_cookbook_view_details.png

Cookbook Files
=====================================================
A cookbook can contain the following types of files:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - File Type
     - Description
   * - Attributes
     - .. tag cookbooks_attribute

       An attribute can be defined in a cookbook (or a recipe) and then used to override the default settings on a node. When a cookbook is loaded during a Chef Infra Client run, these attributes are compared to the attributes that are already present on the node. Attributes that are defined in attribute files are first loaded according to cookbook order. For each cookbook, attributes in the ``default.rb`` file are loaded first, and then additional attribute files (if present) are loaded in lexical sort order. When the cookbook attributes take precedence over the default attributes, Chef Infra Client applies those new settings and values during a Chef Infra Client run on the node.

       .. end_tag

   * - Files
     - .. tag resource_cookbook_file_summary

       Use the **cookbook_file** resource to transfer files from a sub-directory of ``COOKBOOK_NAME/files/`` to a specified path located on a host that is running Chef Infra Client. The file is selected according to file specificity, which allows different source files to be used based on the hostname, host platform (operating system, distro, or as appropriate), or platform version. Files that are located in the ``COOKBOOK_NAME/files/default`` sub-directory may be used on any platform.

       .. end_tag

   * - Libraries
     - .. tag libraries_summary

       A library allows arbitrary Ruby code to be included in a cookbook. The most common use for libraries is to write helpers that are used throughout recipes and custom resources. A library file is a Ruby file that is located within a cookbook's ``/libraries`` directory. Because a library is built using Ruby, anything that can be done with Ruby can be done in a library file, including advanced functionality such as extending built-in Chef classes.

       .. end_tag

   * - Recipes
     - .. tag cookbooks_recipe

       A recipe is the most fundamental configuration element within the organization. A recipe:

       * Is authored using Ruby, which is a programming language designed to read and behave in a predictable manner
       * Is mostly a collection of `resources </resources.html>`__, defined using patterns (resource names, attribute-value pairs, and actions); helper code is added around this using Ruby, when needed
       * Must define everything that is required to configure part of a system
       * Must be stored in a cookbook
       * May be included in another recipe
       * May use the results of a search query and read the contents of a data bag (including an encrypted data bag)
       * May have a dependency on one (or more) recipes
       * Must be added to a run-list before it can be used by Chef Infra Client
       * Is always executed in the same order as listed in a run-list

       .. end_tag

   * - Resources
     - .. tag resources_common

       A resource is a statement of configuration policy that:

       * Describes the desired state for a configuration item
       * Declares the steps needed to bring that item to the desired state
       * Specifies a resource type---such as ``package``, ``template``, or ``service``
       * Lists additional details (also known as resource properties), as necessary
       * Are grouped into recipes, which describe working configurations

       .. end_tag

   * - Templates
     - .. tag template

       A cookbook template is an Embedded Ruby (ERB) template that is used to dynamically generate static text files. Templates may contain Ruby expressions and statements, and are a great way to manage configuration files. Use the **template** resource to add cookbook templates to recipes; place the corresponding Embedded Ruby (ERB) template file in a cookbook's ``/templates`` directory.

       .. end_tag

All of the file types that are part of any cookbook uploaded to the Chef Infra Server are visible from the Chef management console.

Download File
-----------------------------------------------------
To download a file that is located in a cookbook:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Cookbooks**.
#. Select the file type: **Attributes**, **Definitions**, **Files**, **Recipes**, **Templates**, or **Root Files**.
#. Select a file.
#. Click **Download File**:

   .. image:: ../../images/step_manage_webui_policy_cookbook_download.png

#. Specify the location to which the file should be saved.

View a File
-----------------------------------------------------
To view a cookbook file:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Cookbooks**.
#. Select a cookbook.
#. Click the **Content** tab.
#. Select the file type: **Attributes**, **Definitions**, **Files**, **Recipes**, **Templates**, or **Root Files**.
#. Select a file:

   .. image:: ../../images/step_manage_webui_policy_cookbook_file_view.png

Permissions
=====================================================
.. tag server_rbac_permissions

Permissions are used in the Chef Infra Server to define how users and groups can interact with objects on the server. Permissions are configured per-organization.

.. end_tag

.. tag server_rbac_permissions_object

The Chef Infra Server includes the following object permissions:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Permission
     - Description
   * - **Delete**
     - Use the **Delete** permission to define which users and groups may delete an object. This permission is required for any user who uses the ``knife [object] delete [object_name]`` argument to interact with objects on the Chef Infra Server.
   * - **Grant**
     - Use the **Grant** permission to define which users and groups may configure permissions on an object. This permission is required for any user who configures permissions using the **Administration** tab in the Chef management console.
   * - **Read**
     - Use the **Read** permission to define which users and groups may view the details of an object. This permission is required for any user who uses the ``knife [object] show [object_name]`` argument to interact with objects on the Chef Infra Server.
   * - **Update**
     - Use the **Update** permission to define which users and groups may edit the details of an object. This permission is required for any user who uses the ``knife [object] edit [object_name]`` argument to interact with objects on the Chef Infra Server and for any Chef Infra Client to save node data to the Chef Infra Server at the conclusion of a Chef Infra Client run.

.. end_tag

Set
-----------------------------------------------------
To set permissions list for a cookbook object:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Cookbooks**.
#. Select a cookbook.
#. Click the **Permissions** tab.
#. For each group listed under **Name**, select or de-select the **Read**, **Update**, **Delete**, and **Grant** permissions.

Update
-----------------------------------------------------
To update the permissions list for a cookbook object:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Cookbooks**.
#. Select a cookbook.
#. Click the **Permissions** tab.
#. Click the **+ Add** button and enter the name of the user or group to be added.
#. Select or de-select **Read**, **Update**, **Delete**, and **Grant** to update the permissions list for the user or group.

View
-----------------------------------------------------
To view permissions for a cookbook object:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Cookbooks**.
#. Select a cookbook.
#. Click the **Permissions** tab.
#. Set the appropriate permissions: **Delete**, **Grant**, **Read**, and/or **Update**.
