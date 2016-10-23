=====================================================
Release Notes: chef-client 12.5
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for chef-client 12.5 and/or are changes from previous versions. The short version:

* **New way to build custom resources** The process for extending the collection of resources that are built into Chef has been simplified. It is defined only in the ``/resources`` directory using a simplified syntax that easily leverages the built-in collection of resources. (All of the ways you used to build custom resources still work.)
* **"resource attributes" are now known as "resource properties"** In previous releases of Chef, resource properties are referred to as attributes, but this is confusing for users because nodes also have attributes. Starting with chef-client 12.5 release---and retroactively updated for all previous releases of the documentation---"resource attributes" are now referred to as "resource properties" and the word "attribute" now refers specifically to "node attributes".
* **ps_credential helper to embed usernames and passwords** Use the ``ps_credential`` helper on Microsoft Windows to create a ``PSCredential`` object---security credentials, such as a user name or password---that can be used in the **dsc_script** resource.
* **New Handler DSL** A new DSL exists to make it easier to use events that occur during the chef-client run from recipes. The ``on`` method is easily associated with events. The action the chef-client takes as a result of that event (when it occurs) is up to you.
* **The -j / --json-attributes supports policy revisions and environments** The JSON file used by the ``--json-attributes`` option for the chef-client may now contain the policy name and policy group associated with a policy revision or may contain the name of the environment to which the node is associated.
* **verify property now uses path, not file** The ``verify`` property, used by file-based resources such as **remote_file** and **file**, runs user-defined correctness checks against the proposed new file before making the change. For versions of the chef-client prior to 12.5, the name of the temporary file was stored as ``file``; starting with chef-client 12.5, use ``path``. This change is documented as a warning across all versions in any topic in which the ``version`` attribute is documented.
* **depth property added to deploy resource** The ``depth`` property allows the depth of a git repository to be truncated to the specified number of versions.
* **The knife ssl check subcommand supports SNI** Support for Server Name Indication (SNI) is added to the ``knife ssl check`` subcommand.
* **Chef Policy group and name can now be part of the node object** Chef policy is a beta feature of the chef-client that will eventually replace roles, environments or manually specifying the run_list. Policy group and name can now be stored as part of the node object rather than in the client.rb file. A recent version of the Chef server, such as 12.2.0 or higher, is needed to fully utilize this feature.


Custom Resources
-----------------------------------------------------
.. include:: ../../includes_custom_resources/includes_custom_resources.rst

.. note:: See https://docs.chef.io/custom_resources.html for more information about custom resources, including a scenario that shows how to build a ``website`` resource. Read this scenario as an HTML presentation at https://docs.chef.io/decks/custom_resources.html.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_custom_resources/includes_custom_resources_syntax.rst

.. include:: ../../includes_custom_resources/includes_custom_resources_syntax_example.rst


Custom Resource DSL
-----------------------------------------------------
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource.rst

converge_if_changed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_converge_if_changed.rst

Multiple Properties
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_converge_if_changed_multiple.rst

default_action
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_default_action.rst

load_current_value
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_load_current_value.rst

new_resource.property
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_new_resource.rst

property
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_property.rst

desired_state
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_property_desired_state.rst

identity
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_property_identity.rst

Block Arguments
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_property_block_argument.rst

property_is_set?
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_property_is_set.rst

provides
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_provides.rst

override
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_provides_override.rst

reset_property
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_reset_property.rst


Definition vs. Resource
-----------------------------------------------------
.. include:: ../../includes_definition/includes_definition_example.rst

As a Definition
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_definition/includes_definition_example_as_definition.rst

As a Resource
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_definition/includes_definition_example_as_resource.rst

Common Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_definition/includes_definition_example_as_resource_with_common_properties.rst


ps_credential Helper
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_dsc_script_helper_ps_credential.rst


Handler DSL
-----------------------------------------------------
.. include:: ../../includes_dsl_handler/includes_dsl_handler.rst

on Method
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_handler/includes_dsl_handler_method_on.rst

Example: Send Email
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_handler/includes_dsl_handler_slide_send_email.rst

.. note:: See https://docs.chef.io/dsl_handler.html for more information about using event handlers in recipes. Read the scenario for sending email if the chef-client run fails as an HTML presentation at https://docs.chef.io/decks/event_handlers.html.

**Define How Email is Sent**

.. include:: ../../includes_dsl_handler/includes_dsl_handler_slide_send_email_library.rst

**Add the Handler**

.. include:: ../../includes_dsl_handler/includes_dsl_handler_slide_send_email_handler.rst

**Test the Handler**

.. include:: ../../includes_dsl_handler/includes_dsl_handler_slide_send_email_test.rst


New Resource Properties
-----------------------------------------------------
The following property is new for the **deploy** resource:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Property
     - Description
   * - ``depth``
     - **Ruby Type:** Integer

       The depth of a git repository, truncated to the specified number of revisions.


Specify Policy Revision
-----------------------------------------------------
Use the following command to specify a policy revision:

.. code-block:: bash

   $ chef client -j JSON

where the JSON file is similar to:

.. code-block:: javascript

   {
     "policy_name": "appserver",
     "policy_group": "staging"
   }

Or use the following settings to specify a policy revision in the client.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``policy_group``
     - The name of a policy, as identified by the ``name`` setting in a Policyfile.rb file.
   * - ``policy_name``
     - The name of a policy group that exists on the Chef server.

New Configuration Settings
-----------------------------------------------------
The following settings are new for the client.rb file and enable the use of policy files:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``named_run_list``
     - The run-list associated with a policy file.
   * - ``policy_group``
     - The name of a policy, as identified by the ``name`` setting in a Policyfile.rb file. (See "Specify Policy Revision" in this readme for more information.)
   * - ``policy_name``
     - The name of a policy group that exists on the Chef server. (See "Specify Policy Revision" in this readme for more information.)


chef-client Options
-----------------------------------------------------
The following options are new or updated for the chef-client executable and enable the use of policy files:

``-n NAME``, ``--named-run-list NAME``
   The run-list associated with a policy file.

``-j PATH``, ``--json-attributes PATH``
   This option now supports using a JSON file to associate a policy revision.

   .. include:: ../../includes_policy/includes_policy_ctl_run_list.rst

   This option also supports using a JSON file to associate an environment:

   .. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_environment.rst


Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
